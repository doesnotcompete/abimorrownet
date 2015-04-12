class Award < ActiveRecord::Base
  belongs_to :voting
  has_many :nominations, dependent: :destroy
  has_many :users, through: :nominations

  validates :title, :tiers, :voting, presence: true
end
