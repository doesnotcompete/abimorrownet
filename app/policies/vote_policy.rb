class VotePolicy < ApplicationPolicy
  def initialize(user, vote)
    @user = user
    @vote = vote
  end

  def show
    if @vote.locked?
      true
    else
      @vote.user == @user || @user.admin?
    end
  end

  def lock
    @vote.user == @user
  end

  def index
    @user.admin?
  end

  def create
    @user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
