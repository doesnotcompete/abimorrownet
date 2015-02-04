class TeacherPolicy < ApplicationPolicy
  def initialize(user, teacher)
    @user = user
    @teacher = teacher
  end

  def show?
    true
  end

  def update?
    #@user.admin? || @user.moderator?
    true
  end

  def create?
    true
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
