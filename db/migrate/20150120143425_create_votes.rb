class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :voting, index: true
      t.references :voting_option, index: true
      t.string :uid
      t.boolean :locked
      t.integer :max_choices

      t.timestamps
    end
  end
end
