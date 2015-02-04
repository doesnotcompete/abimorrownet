class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.boolean :shippable
      t.boolean :available

      t.timestamps
    end
  end
end
