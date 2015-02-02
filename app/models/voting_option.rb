class VotingOption < ActiveRecord::Base
  belongs_to :voting
  belongs_to :user

  has_many :voted_options
  has_many :votes, through: :voted_options

  validates :voting_id, presence: true

end
