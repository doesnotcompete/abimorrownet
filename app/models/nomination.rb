class Nomination < ActiveRecord::Base
  belongs_to :award
  belongs_to :user
end
