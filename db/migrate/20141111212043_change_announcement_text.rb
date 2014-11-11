class ChangeAnnouncementText < ActiveRecord::Migration
  def change
    change_column :announcements, :text, :text
  end
end
