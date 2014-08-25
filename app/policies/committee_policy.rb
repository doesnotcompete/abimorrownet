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

  class Scope < Scope
    def resolve
      scope
    end
  end
end
