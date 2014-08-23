class Committee < ActiveRecord::Base
  has_many :committee_roles
  has_many :users, through: :committee_roles
end
