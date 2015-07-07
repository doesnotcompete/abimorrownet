class CreateDeliveryAddresses < ActiveRecord::Migration
  def change
    create_table :delivery_addresses do |t|
      t.references :order, index: true
      t.string :street
      t.string :city
      t.string :plz

      t.timestamps
    end
  end
end
