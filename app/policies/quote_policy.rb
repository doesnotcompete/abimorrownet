class QuotePolicy < ApplicationPolicy
  def initialize(user, quote)
    @user = user
    @quote = quote
  end

  def edit?
    @user.moderator? || @quote.author == current_user
  end

  def create?
    true
  end

  def destroy?
    @user.moderator? || @quote.author == @user || @user.profile == @quote.quotable
  end

  def approve?
    @user.moderator? || @user.profile == @quote.quotable
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
