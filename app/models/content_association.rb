class ContentAssociation < ActiveRecord::Base
  belongs_to :content
  belongs_to :profile
  
  validates :profile, :content, presence: true
end
