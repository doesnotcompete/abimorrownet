class Award < ActiveRecord::Base
  belongs_to :voting
  has_many :nominations
  has_many :users, through: :nominations

  validates :title, :tiers, :voting, presence: true
end
