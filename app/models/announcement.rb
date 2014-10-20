class Announcement < ActiveRecord::Base
  validates :title, :text, presence: true

  scope :dashboard, -> { where(present: true) }
end
