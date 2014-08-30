class Quote < ActiveRecord::Base
  belongs_to :quotable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: "creator_id"

  scope :pending, -> { where(approved: false) }
end
