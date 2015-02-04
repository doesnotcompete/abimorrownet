class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description
      t.references :user, index: true
      t.text :address
      t.string :plz
      t.string :city
      t.boolean :processed
      t.references :assigned, index: true
      t.boolean :shipped
      t.string :shipping_id

      t.timestamps
    end
  end
end
