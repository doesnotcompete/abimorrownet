class Committee < ActiveRecord::Base
  has_many :committee_roles
  has_many :users, through: :committee_roles

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end
end
