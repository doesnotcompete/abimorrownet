class User < ActiveRecord::Base
  has_many :committee_roles, dependent: :destroy
  has_many :committees, through: :committee_roles

  has_many :comments

  belongs_to :group

  has_many :votes
  has_many :votings, through: :votes

  has_many :nominations

  has_many :contents

  has_many :orders

  has_one :profile, as: :profileable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :email, presence: true

  delegate :first_name, :last_name, :full_name, :quotes, to: :profile

  scope :invited, -> { where("invitation_token IS NOT NULL") }
  scope :active, -> { joins(:profile) }
  scope :notify, -> { where(notify: true) }


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.enable_notifications_for_all
    User.all.each do |user|
      user.stop_key = SecureRandom.hex(6)
      user.notify = true
      user.save!
    end
  end

  def associate_identity(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    save
  end

  def remove_association
    self.provider = nil
    self.uid = nil
    save
  end

  def has_identity?
    provider? && uid?
  end
end
