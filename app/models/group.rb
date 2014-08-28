class Group < ActiveRecord::Base
  belongs_to :teacher
  has_many :users

  extend FriendlyId
  friendly_id :title, use: :slugged
end
