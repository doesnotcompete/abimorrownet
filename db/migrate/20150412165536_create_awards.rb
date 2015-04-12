class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title
      t.integer :tiers
      t.references :voting, index: true

      t.timestamps
    end
  end
end
