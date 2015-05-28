class AddLockedToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :locked, :boolean
  end
end
