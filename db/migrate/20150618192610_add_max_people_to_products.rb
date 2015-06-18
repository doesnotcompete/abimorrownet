class AddMaxPeopleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :max_people, :integer
  end
end
