class User < ActiveRecord::Base
  has_many :committee_roles
  has_many :committees, through: :committee_roles

  has_many :comments

  belongs_to :group

  has_many :votes
  has_many :votings, through: :votes

  has_one :profile, as: :profileable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, :last_name, :email, presence: true
end
