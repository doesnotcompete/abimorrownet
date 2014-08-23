class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.string :title
      t.text :description
      t.string :options, array: true, default: []

      t.belongs_to :committee

      t.timestamps
    end
  end
end
