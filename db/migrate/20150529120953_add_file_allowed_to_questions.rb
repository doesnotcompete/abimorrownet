class AddFileAllowedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :fileAllowed, :boolean
  end
end
