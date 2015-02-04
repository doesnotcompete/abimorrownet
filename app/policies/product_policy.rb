class ProductPolicy < ApplicationPolicy
  def initialize(user, product)
    @user = user
    @product = product
  end

  def create?
    @user.admin?
  end

  def show?
    @user.admin?
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

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
