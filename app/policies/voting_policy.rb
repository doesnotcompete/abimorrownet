class VotingPolicy < ApplicationPolicy
  def initialize(user, voting)
    @user = user
    @voting = voting
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

  def results?
    @user.admin? || @voting.finished?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
