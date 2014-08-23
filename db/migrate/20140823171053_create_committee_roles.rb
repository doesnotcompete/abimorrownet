class CreateCommitteeRoles < ActiveRecord::Migration
  def change
    create_table :committee_roles do |t|
      t.string :title
      t.text :description
      t.belongs_to :user
      t.belongs_to :committee

      t.timestamps
    end
  end
end
