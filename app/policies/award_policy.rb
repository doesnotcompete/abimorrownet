class AwardPolicy < ApplicationPolicy
  def initialize(user, award)
    @user = user
    @award = award
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
