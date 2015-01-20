class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new

  end

  private

  def load_voting
    klass = [Voting].detect { |c| params["#{c.name.underscore}_id"]}
    @voting = klass.find(params["#{klass.name.underscore}_id"]) || klass.find(params["#{klass.name.underscore}_id"]) if klass
  end
end
