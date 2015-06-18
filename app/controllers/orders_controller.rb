class OrdersController < ApplicationController
  #before_filter :authenticate_user!
  #before_filter :ensure_profile!

  def new
    #authorize :order, :create?

    @order = Order.new
  end

  def shipping
    @school_shipping = (params[:order][:shipped] == "school")
    session[:school_shipping] = @school_shipping
    session[:products] = params[:order][:product_ids].reject! { |c| c.empty? }

    @products = Product.find(session[:products])
    @order = Order.new

    @total = 0

    @products.each do |product|
      @total += product.price
    end

    unless @school_shipping then @total += 0.00 end
  end

  def create
    @products = Product.find(session[:products])

    @order = Order.new(order_params)
    @order.shipped = !session[:school_shipping]
    if current_user
      @order.user = current_user
      current_user.profile.premium = true
    end
    
    @order.save!

    @products.each do |product|
      @order.order_position.create(product: product)
      
      if product.ticketable
        @order.ticketable = true
        @order.save!
      end
    end

    session[:school_shipping] = nil;
    session[:products] = nil;

    if @order.persisted?
      OrderMailer.order_confirmation(@order).deliver
      if @order.products.first.ticketable
        redirect_to new_order_ticket_path(@order)
      else
        redirect_to @order
      end
    else
      render :new, notice: "Fehler"
    end
  end

  def show
    @order = Order.find(params[:id])

    authorize @order
  end

  def index
    @orders = Order.all

    authorize @orders
  end

  def edit
    @order = Order.find(params[:id])
    authorize @order
  end

  def update
    @order = Order.find(params[:id])
    authorize @order

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, notice: "Fehler."
    end
  end

  def paid
    authorize :order, :paid?

    @order = Order.find(params[:id])
    @order.processed = true
    @order.save!

    OrderMailer.order_paid(@order).deliver

    redirect_to @order, notice: "Bestellung als bezahlt markiert."
  end

  def destroy
    @order = Order.find(params[:id])

    authorize @order
    @order.destroy!
    redirect_to orders_url, notice: "Bestellung gelöscht."
  end

  private

  def order_params
    params.require(:order).permit(:description, :address, :plz, :city, :email, :name, :processed)
  end
end
