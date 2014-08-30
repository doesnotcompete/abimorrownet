class Group < ActiveRecord::Base
  belongs_to :teacher
  has_many :users

  extend FriendlyId
  friendly_id :title, use: :slugged

  def teacher_name
    "#{teacher.first_name} #{teacher.last_name}" rescue "???"
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
