class TeacherPolicy < ApplicationPolicy
  def initialize(user, teacher)
    @user = user
    @teacher = teacher
  end

  def show?
    true
  end

  def update?
    @user.admin? || @user.moderator?
  end

  def create?
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
