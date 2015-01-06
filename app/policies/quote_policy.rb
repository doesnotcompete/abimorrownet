class QuotePolicy < ApplicationPolicy
  def initialize(user, quote)
    @user = user
    @quote = quote
  end

  def edit?
    (!@quote.approved? && @quote.author == @user) || @user.moderator? || @user.profile == @quote.quotable
  end

  def update?
    (!@quote.approved? && @quote.author == @user) || @user.moderator? || @user.profile == @quote.quotable
  end

  def create?
    true
  end

  def destroy?
    @user.moderator? || (!@quote.approved? && @quote.author == @user) || @user.profile == @quote.quotable
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
