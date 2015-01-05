class ContentPolicy < ApplicationPolicy
  def initialize(user, content)
    @user = user
    @content = content
  end

  def create?
    true
  end

  def index?
    @user.moderator?
  end

  def show?
    @user.moderator? || @content.user == user
  end

  def edit?
    @user.moderator? || @content.user == user
  end

  def update?
    @user.moderator? || @content.user == user
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
