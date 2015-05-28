class ContentProblem < ActiveRecord::Base
  belongs_to :content
  
  validates :reason, presence: true
end
