class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.belongs_to :profile
      t.belongs_to :author

      t.timestamps
    end
  end
end
