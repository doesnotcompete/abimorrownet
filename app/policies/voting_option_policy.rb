class VotingOptionPolicy < ApplicationPolicy
  def initialize(user, voting_option)
    @user = user
    @voting_option = voting_option
    @voting = voting_option.voting
  end

  def create?
    @user.admin? || @voting.interactive? || @voting.election?
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
