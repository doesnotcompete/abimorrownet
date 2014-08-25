class UserPolicy < ApplicationPolicy
  def initialize(current_user, user)
    @current = current_user
    @user = user
  end

  def list_invited?
    @current.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
