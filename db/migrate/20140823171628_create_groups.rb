class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description

      t.belongs_to :teacher

      t.timestamps
    end
  end
end
