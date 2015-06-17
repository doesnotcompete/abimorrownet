class AddOrderToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :order, index: true
  end
end
