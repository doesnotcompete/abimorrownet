class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :kind
      t.string :text
      t.references :user, index: true

      t.timestamps
    end
  end
end
