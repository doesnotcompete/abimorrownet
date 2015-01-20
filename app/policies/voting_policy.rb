class VotingPolicy < ApplicationPolicy
  def initialize(current_user, voting)
    @current = current_user
    @voting = voting
  end

  def create?
    @current.admin?
  end

  def edit?
    @current.admin?
  end

  def update?
    @current.admin?
  end

  def destroy?
    @current.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
