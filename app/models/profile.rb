class Profile < ActiveRecord::Base
  belongs_to :profileable, polymorphic: true
  belongs_to :user, -> { where(profiles: {profileable_type: 'User'}) }, foreign_key: 'profileable_id'
  has_many :comments
  has_many :quotes, as: :quotable

  validates :first_name, :last_name, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:first_name, :last_name]
    ]
  end
end
