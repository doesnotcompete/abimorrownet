class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
    unless current_user.admin?
      redirect_to root_url, notice: "Nicht berechtigt."
      return false
    end
  end

  def create
    #TEMP
    unless current_user.admin?
      redirect_to root_url, notice: "Nicht berechtigt."
      return false
    end

    if Vote.create_votes_for_all(@voting, params[:votes][:max_choices])
      flash[:notice] = "Wahlkarten erstellt."
      redirect_to @voting
    else
      flash[:notice] = "Fehler!"
      redirect_to @voting
    end
  end

  def show
    @vote = Vote.includes(:voted_options).find(params[:id])

    #TEMP
    unless current_user.admin? || @vote.locked? || @vote.user == current_user
      redirect_to root_url, notice: "Nicht berechtigt."
      return false
    end
  end

  def index
    #TEMP
    unless current_user.admin?
      redirect_to root_url, notice: "Nicht berechtigt."
      return false
    end

    @votes = Vote.where(voting: params[:voting_id])
  end

  def lock
    @vote = Vote.find(params[:vote_id])
    #TEMP
    unless @vote.user == current_user
      redirect_to root_url, notice: "Nicht berechtigt."
      return false
    end

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
