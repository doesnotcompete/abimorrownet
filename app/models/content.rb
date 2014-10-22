class Content < ActiveRecord::Base
  belongs_to :user

  has_attached_file :file
  do_not_validate_attachment_file_type :file
  validates_attachment_size :file, :less_than => 5.megabytes

  validates :title, :kind, presence: true
end
