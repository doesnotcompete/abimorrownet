class AddAttachmentFileToAnswers < ActiveRecord::Migration
  def self.up
    change_table :answers do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :answers, :file
  end
end
