class NominationPolicy < ApplicationPolicy
  def initialize(user, nomination)
    @user = user
    @nomination = nomination
  end

  def accept?
    (@nomination.user == user && @nomination.accepted.nil?) || user.admin?
  end

  def dismiss?
    (@nomination.user == user && @nomination.accepted.nil?) || user.admin?
  end

  def reset?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
