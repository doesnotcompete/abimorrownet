class AddSlugToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :slug, :string
    add_index :teachers, :slug, unique: true
  end
end
