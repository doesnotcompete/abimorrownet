class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
