class Teacher < ActiveRecord::Base
  has_one :group

  has_many :quotes, as: :quotable

  validates :email, :first_name, :last_name, presence: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      [:first_name, :last_name]
    ]
  end

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed?
  end

  def full_name
    self.first_name + " " + self.last_name
  end
end
