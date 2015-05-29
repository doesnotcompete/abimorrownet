class Profile < ActiveRecord::Base
  belongs_to :profileable, polymorphic: true
  belongs_to :user, class_name: "User", foreign_key: "profileable_id"
  belongs_to :teacher, class_name: "Teacher", foreign_key: "profileable_id"
  has_many :comments
  has_many :quotes, as: :quotable
  has_many :content_associations
  has_many :contents, through: :content_associations
  has_many :content_problems
  has_many :answers

  validates :first_name, :last_name, presence: true

  delegate :group, :email, to: :profileable

  accepts_nested_attributes_for :profileable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  scope :students, -> { where(profileable_type: "User") }
  scope :teachers, -> { where(profileable_type: "Teacher") }

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:first_name, :last_name]
    ]
  end

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed?
  end

  def group_title
    self.user.group.title
  end

  def full_name
    self.profileable.first_name + " " + self.profileable.last_name
  end
  
  def is_teacher?
    self.profileable_type == "Teacher"
  end
  
  def self.generateForTeachers
    Teacher.all.each do |teacher|
      Profile.create(profileable: teacher, first_name: teacher.first_name, last_name: teacher.last_name)
    end
  end
end
