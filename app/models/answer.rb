class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :profile
  
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
