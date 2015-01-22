class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
    authorize :vote, :create?
  end

  def create
    authorize :vote, :create?

    if Vote.create_votes_for_all(@voting, params[:votes][:max_choices])
      flash[:notice] = "Wahlkarten erstellt."
      redirect_to @voting
    else
      flash[:notice] = "Fehler!"
      redirect_to @voting
    end
  end

  def show
    authorize :vote, :show?

    @vote = Vote.includes(:voted_options).find(params[:id])
  end

  def index
    authorize :vote, :index?

    @votes = Vote.where(voting: params[:voting_id])
  end

  def lock
    @vote = Vote.find(params[:vote_id])
    authorize @vote

    @vote.locked = true
    @vote.user = nil
    @vote.save!

    if @vote.persisted?
      redirect_to root_url, notice: "Deine Stimme wurde gezählt."
    else
      redirect_to root_url, notice: "Fehler. Bitte melde dich bei uns."
    end
  end

  private

  def load_voting
    @voting = Voting.find(params[:voting_id])
  end

  #def load_voting
  #  klass = [Voting].detect { |c| params["#{c.name.underscore}_id"]}
  #  @voting = klass.find(params["#{klass.name.underscore}_id"]) || klass.find(params["#{klass.name.underscore}_id"]) if klass
  #end
end
