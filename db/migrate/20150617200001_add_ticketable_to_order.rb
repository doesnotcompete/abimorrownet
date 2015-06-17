class AddTicketableToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :ticketable, :boolean
  end
end
