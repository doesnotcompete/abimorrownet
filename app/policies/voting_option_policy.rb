class VotingOptionPolicy < ApplicationPolicy
  def initialize(user, voting_option)
    @user = user
    @voting_option = voting_option
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
