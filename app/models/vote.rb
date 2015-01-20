class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voting
  has_many :voting_options, through: :voted_options

  def create_votes_for_all(voting, voting_options)
    User.all.each do |user|
      vote = self.new
      vote.user = user
      vote.voting
      vote.voting_options = voting_options
      vote.uid = SecureRandom.base58(10)
      vote.save
    end
  end
end
