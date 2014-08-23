class Voting < ActiveRecord::Base
  belongs_to :committee
  has_many :votes
end
