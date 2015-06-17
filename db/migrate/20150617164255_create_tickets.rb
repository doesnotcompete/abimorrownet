class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :product, index: true
      t.boolean :validated
      t.text :people, array: true, default: []
      t.text :preferences, array: true, default: []

      t.timestamps
    end
  end
end
