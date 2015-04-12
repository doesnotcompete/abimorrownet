class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|
      t.references :award, index: true
      t.references :user, index: true
      t.integer :tier
      t.boolean :accepted

      t.timestamps
    end
  end
end
