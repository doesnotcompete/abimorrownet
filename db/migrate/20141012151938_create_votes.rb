class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :used
      t.integer :count
      t.string :options, array: true, default: []
      t.belongs_to :vote
      t.belongs_to :user

      t.timestamps
    end
  end
end
