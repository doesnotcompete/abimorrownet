class GroupPolicy < ApplicationPolicy
  def initialize(current_user, group)
    @current = current_user
    @group = group
  end

  def index?
    true
  end

  def create?
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
