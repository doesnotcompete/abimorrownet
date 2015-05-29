class AccessTokenPolicy < ApplicationPolicy
  def initialize(user, policy)
    @user = user
    @policy = policy
  end
  
  def index?
    @user.admin?
  end
  
  def create?
    @user.admin?
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
