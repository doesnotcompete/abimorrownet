class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
