class AddKindToDeliveryAddresses < ActiveRecord::Migration
  def change
    add_column :delivery_addresses, :kind, :string
  end
end
