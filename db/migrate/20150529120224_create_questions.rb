class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.boolean :teacher
      t.boolean :active

      t.timestamps
    end
  end
end
