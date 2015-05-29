class AddProfileToContentProblems < ActiveRecord::Migration
  def change
    add_reference :content_problems, :profile, index: true
  end
end
