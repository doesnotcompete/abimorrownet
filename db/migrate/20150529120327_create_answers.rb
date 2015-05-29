class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.references :question, index: true
      t.references :profile, index: true

      t.timestamps
    end
  end
end
