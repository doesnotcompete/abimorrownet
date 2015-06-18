class TicketPolicy < ApplicationPolicy
  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end
  
  def show?
    @user.admin? || @user == @ticket.order.user
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
