class Voting < ActiveRecord::Base
  has_many :voting_options
  has_many :votes

  validates :title, :start_time, :end_time, presence: true

  scope :active, -> { where('end_time > ? AND start_time < ?', DateTime.now, DateTime.now) }

  def active?
    self.end_time > DateTime.now && self.start_time < DateTime.now rescue true
  end
end
