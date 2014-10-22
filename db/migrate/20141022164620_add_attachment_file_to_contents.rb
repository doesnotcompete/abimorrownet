class AddAttachmentFileToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :contents, :file
  end
end
