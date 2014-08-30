class AddCreatorIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :creator_id, :integer
    add_index :quotes, :creator_id
  end
end
