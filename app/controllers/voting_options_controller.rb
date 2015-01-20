class VotingOptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
  end

  def create
    @quote = @voting.voting_options.create(title: params[:voting_option][:title], description: params[:voting_option][:description])

    if @quote.persisted?
      redirect_to @voting
    else
      render :new
    end
  end

  private

  def load_voting
    klass = [Voting].detect { |c| params["#{c.name.underscore}_id"]}
    @voting = klass.find(params["#{klass.name.underscore}_id"]) || klass.find(params["#{klass.name.underscore}_id"]) if klass
  end
end
