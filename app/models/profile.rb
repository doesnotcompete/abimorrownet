class Profile < ActiveRecord::Base
  belongs_to :profileable, polymorphic: true
  belongs_to :user, -> { where(profiles: {profileable_type: 'User'}) }, foreign_key: 'profileable_id'
  has_many :comments
  has_many :quotes, as: :quotable

  validates :first_name, :last_name, presence: true
end
