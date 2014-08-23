class Profile < ActiveRecord::Base
  belongs_to :profileable, polymorphic: true
  has_many :comments
  has_many :quotes, as: :quotable
end
