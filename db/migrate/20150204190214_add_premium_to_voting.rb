class AddPremiumToVoting < ActiveRecord::Migration
  def change
    add_column :votings, :premium, :boolean
  end
end
