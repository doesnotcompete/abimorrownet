class AddQuantityToOrderPositions < ActiveRecord::Migration
  def change
    add_column :order_positions, :quantity, :integer
  end
end
