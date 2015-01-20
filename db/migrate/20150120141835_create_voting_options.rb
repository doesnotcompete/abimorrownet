class CreateVotingOptions < ActiveRecord::Migration
  def change
    create_table :voting_options do |t|
      t.string :title
      t.text :description
      t.references :voting, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
