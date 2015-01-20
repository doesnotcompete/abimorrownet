class VotingOption < ActiveRecord::Base
  belongs_to :voting
  belongs_to :user

  has_many :votes, through: :voted_options
end
