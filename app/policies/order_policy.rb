class OrderPolicy < ApplicationPolicy
  def initialize(user, order)
    @user = user
    @order = order
  end

  def create?
    true
  end

  def show?
    true
  end

  def index?
    @user.admin?
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def paid?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
