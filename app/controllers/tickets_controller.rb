class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  
  def new_order
    @products = Product.where(ticketable: true)
    @order = Order.new
  end
  
  def index
    @orders = (current_user.admin ? Order.where(ticketable: true) : Order.where(user: current_user).where(ticketable: true))
  end
  
  def order
    
  end
end
