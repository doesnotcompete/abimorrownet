class ContentPolicy < ApplicationPolicy
  def initialize(user, content)
    @user = user
    @content = content
  end

  def edit?
    @user.moderator? || @content.user == current_user
  end

  def create?
    true
  end

  def index?
    @user.moderator?
  end

  def show?
    @user.moderator?
  end

  def edit?
    @user.moderator?
  end

  def update?
    @user.moderator?
  end

  def destroy?
    @user.moderator?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
