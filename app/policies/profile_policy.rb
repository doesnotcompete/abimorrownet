class ProfilePolicy < ApplicationPolicy
  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def update?
    @user.admin? || @user.profile == @profile
  end

  def show?
    true
  end

  def create?
    @user.admin? || !@user.profile
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
