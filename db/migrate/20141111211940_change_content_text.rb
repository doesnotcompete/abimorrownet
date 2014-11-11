class ChangeContentText < ActiveRecord::Migration
  def change
    change_column :contents, :text, :text
  end
end
