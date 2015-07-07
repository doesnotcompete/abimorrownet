class AddTypeToDeliveryAddress < ActiveRecord::Migration
  def change
    add_column :delivery_addresses, :type, :string
  end
end
