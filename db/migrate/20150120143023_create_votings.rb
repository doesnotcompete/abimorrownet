class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :interactive

      t.timestamps
    end
  end
end
