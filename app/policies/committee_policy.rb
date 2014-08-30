class CommitteePolicy < ApplicationPolicy
  def initialize(user, committee)
    @user = user
    @committee = committee
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  def participate?
    !@user.committees.include?(@committee)
  end

  def departicipate?
    @user.committees.include?(@committee)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
