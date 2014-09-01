class Quote < ActiveRecord::Base
  belongs_to :quotable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: "creator_id"

  validates :text, presence: true

  scope :pending, -> { where(approved: false) }

  def self.pending_overview(user)
    if user.moderator?
      self.pending
    else
      self.pending.where(quotable: user.profile)
    end
  end
end
