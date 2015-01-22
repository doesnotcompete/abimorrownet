class VotedOption < ActiveRecord::Base
  belongs_to :vote
  belongs_to :voting_option
end
