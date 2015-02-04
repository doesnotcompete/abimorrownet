class AddStopKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stop_key, :string
  end
end
