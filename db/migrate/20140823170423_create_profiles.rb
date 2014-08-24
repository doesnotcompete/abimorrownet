class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about
      t.references :profileable, polymorphic: true

      t.timestamps
    end
  end
end
