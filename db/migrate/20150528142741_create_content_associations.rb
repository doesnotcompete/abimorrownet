class CreateContentAssociations < ActiveRecord::Migration
  def change
    create_table :content_associations do |t|
      t.references :content, index: true
      t.references :profile, index: true
      t.boolean :locked

      t.timestamps
    end
  end
end
