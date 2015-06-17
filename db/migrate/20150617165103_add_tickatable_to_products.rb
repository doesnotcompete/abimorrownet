class AddTickatableToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ticketable, :boolean
  end
end
