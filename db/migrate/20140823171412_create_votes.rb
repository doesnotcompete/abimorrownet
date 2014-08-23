class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :option

      t.belongs_to :user
      t.belongs_to :voting

      t.timestamps
    end
  end
end
