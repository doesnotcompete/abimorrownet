class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about_me
      t.references :profileable, polymorphic: true

      t.timestamps
    end
  end
end
