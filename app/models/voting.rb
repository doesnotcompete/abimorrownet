class Voting < ActiveRecord::Base
  has_many :voting_options
  has_many :votes

  validates :title, :start_time, :end_time, presence: true

  scope :active, -> { where('end_time > ? AND start_time < ?', DateTime.now, DateTime.now) }
  scope :finished, -> { where('end_time > ?', DateTime.now) }

  def count_users
    results = []
    self.votes.each do |vote|
      if vote.locked then
        vote.voting_options.each do |option|
          (results[option.user_id] += 1) rescue (results[option.user_id] = 1)
        end
      end
    end

    return results
  end

  def active?
    self.end_time > DateTime.now && self.start_time < DateTime.now rescue true
  end

  def finished?
    self.end_time < DateTime.now rescue true
  end
end
