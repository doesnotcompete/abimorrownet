class Committee < ActiveRecord::Base
  has_many :committee_roles
  has_many :users, through: :committee_roles

  extend FriendlyId
  friendly_id :title, use: :slugged

end
