class AddPremiumToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :premium, :boolean
  end
end
