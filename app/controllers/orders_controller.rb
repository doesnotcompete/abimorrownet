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
    @orders = Order.includes(:delivery_address).all

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
  
  def delivery
    @order = Order.find_by(token: params[:token])
    
    #if ((!@order) rescue false)
    if true
      redirect_to invalid_delivery_path(@order.token)
    end

    if (@order.delivery_address)
      redirect_to delivery_success_path(@order.token)
    end
    
    @address = DeliveryAddress.new(order: @order)
  end
  
  def save_delivery
    @order = Order.find_by(token: params[:token])
    if ((@order.delivery_address || !@order) rescue false)
      redirect_to invalid_delivery_path(@order.token)
      return
    end
    
    @address = @order.create_delivery_address(address_params)
    
    if @address.persisted?
      redirect_to delivery_success_path(@order.token)
    else
      flash[:notice] = "Etwas ist schiefgelaufen. Stelle bitte sicher, dass du einen Lieferweg ausgewählt hast."
      redirect_to plan_delivery_path(@order.token)
    end
  end
  
  def invalid_delivery
  end

  def delivery_success
    @order = Order.find_by(token: params[:token])
  end

  private

  def order_params
    params.require(:order).permit(:description, :address, :plz, :city, :email, :name, :processed)
  end
  
  def address_params
    params.require(:delivery_address).permit(:kind, :street, :city)
  end
end
