class AddCompleteToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :complete, :bool
  end
end
