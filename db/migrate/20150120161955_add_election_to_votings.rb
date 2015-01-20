class AddElectionToVotings < ActiveRecord::Migration
  def change
    add_column :votings, :election, :boolean
  end
end
