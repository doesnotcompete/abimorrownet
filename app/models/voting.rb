class Voting < ActiveRecord::Base
  has_many :voting_options
  has_many :votes

  scope :active, -> { where('end_time > ?', DateTime.now) }
end
