class AddVoteOptions < ActiveRecord::Migration
  def change
    create_table :voted_options do |t|
      t.belongs_to :vote, index: true
      t.belongs_to :voting_option, index: true
    end
  end
end
