class ContentProblem < ActiveRecord::Base
  belongs_to :content
  belongs_to :profile
  
  validates :reason, presence: true
end
