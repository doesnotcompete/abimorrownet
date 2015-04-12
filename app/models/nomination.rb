class Nomination < ActiveRecord::Base
  belongs_to :award
  belongs_to :user

  scope :not_dismissed, -> { where('accepted != false OR accepted IS NULL') }
end
