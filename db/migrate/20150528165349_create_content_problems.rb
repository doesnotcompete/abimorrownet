class CreateContentProblems < ActiveRecord::Migration
  def change
    create_table :content_problems do |t|
      t.references :content, index: true
      t.string :reason
      t.text :description
      t.string :email
      t.boolean :processed
      t.boolean :legit

      t.timestamps
    end
  end
end
