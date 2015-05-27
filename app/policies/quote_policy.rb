class QuotePolicy < ApplicationPolicy
  def initialize(user, quote)
    @user = user
    @quote = quote
  end

  def edit?
    #(!@quote.approved? && (@quote.author == @user || @user.profile == @quote.quotable)) || @user.moderator?
    @user.moderator?
  end

  def update?
    #(!@quote.approved? && (@quote.author == @user || @user.profile == @quote.quotable)) || @user.moderator?
    @user.moderator?
  end

  def create?
    #true
    @user.moderator?
  end

  def destroy?
    @user.moderator? || (!@quote.approved? && (@quote.author == @user || @user.profile == @quote.quotable))
  end

  def approve?
    @user.moderator? || (@user.profile == @quote.quotable && @user != @quote.author)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
