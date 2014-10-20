class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :text
      t.string :file
      t.boolean :present

      t.timestamps
    end
  end
end
