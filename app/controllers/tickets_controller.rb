class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :get_order, only: [:new, :create]
  before_filter :ensure_ticket_does_not_exist, only: [:new, :create]
  
  def new_order
    @products = Product.where(ticketable: true)
    @order = Order.new
  end
  
  def index
    @orders = (current_user.admin ? Order.where(ticketable: true) : Order.where(user: current_user).where(ticketable: true))
  end
  
  def order
    
  end
  
  def new
    @ticket = Ticket.new
    3.times { @ticket.ticket_preference_associations.new }
    @profiles = Profile.all
  end
  
  def create
    return unless (current_user.admin || @order.user == current_user)
    
    Ticket.transaction do
      people = params[:ticket][:people].split(",")

      
      if people.count > @order.products.first.max_people
        redirect_to new_order_ticket_path(@order), notice: "Zu viele Begleitpersonen angegeben."
        return
      end
      
      @ticket = Ticket.create(order: @order, people: people, number: rand(1000000..9999999), product: @order.products.first)
      puts params
      3.times do |i|
        @ticket.ticket_preference_associations.create(profile: Profile.find(params[:ticket][:ticket_preference_associations_attributes][i.to_s.to_sym][:profile_id])) unless (params[:ticket][:ticket_preference_associations_attributes][i.to_s.to_sym][:profile_id]).empty?
      end
      
      @ticket.create_pdf
    end
    
    OrderMailer.ticket_created(@ticket).deliver
    
    redirect_to @ticket
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    authorize @ticket
  end
  
  def download
    @ticket = Ticket.find(params[:id])
    authorize @ticket, :show?
    send_file "#{Rails.root}/tickets/#{@ticket.number}.pdf"
  end
  
  private
  
  def get_order
    @order = Order.find(params[:order_id])
  end
  
  def ensure_ticket_does_not_exist
    if Ticket.find_by(order: @order)
      flash[:notice] = "Dein Ticket existiert bereits."
      redirect_to Ticket.find_by(order: @order)
      return
    end
  end
end
