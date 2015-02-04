class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
    authorize :vote, :create?
  end

  def new_selection
    authorize :vote, :create?

    @max_choices = params[:max_choices]
  end

  def create
    authorize :vote, :create?

    if params[:commit] == 'all'
      if Vote.create_votes_for_all(@voting, params[:votes][:max_choices], params[:votes][:notify])
        flash[:notice] = "Wahlkarten erstellt."
        redirect_to @voting
      else
        flash[:notice] = "Fehler!"
        redirect_to @voting
      end
    else
      if params[:votes][:users]
        if Vote.create_votes_for_users(@voting, params[:votes][:max_choices], User.find(params[:votes][:users].reject! { |c| c.empty? }), params[:votes][:notify])
          flash[:notice] = "Wahlkarten erstellt."
          redirect_to root_url
        else
          flash[:notice] = "Fehler!"
          redirect_to @voting
        end
      else
        redirect_to new_selective_votes_path(@voting, params[:votes][:max_choices])
      end
    end
  end

  def show
    @vote = Vote.includes(:voted_options).find(params[:id])

    authorize @vote
    #TEMP
    #unless current_user.admin? || @vote.locked? || @vote.user == current_user
    #  redirect_to root_url, notice: "Nicht berechtigt."
    #  return false
    #end
  end

  def index
    @votes = Vote.where(voting: params[:voting_id])

    authorize @votes
  end

  def validate_vote
  end

  def validate
    @vote = Vote.find_by(uid: params[:votes][:uid])

    if @vote.present? && @vote.locked?
      redirect_to voting_vote_path(@vote.voting, @vote)
    else
      redirect_to vote_validation_path, notice: "Stimmkennung nicht gefunden oder Stimme noch nicht abgegeben."
    end
  end

  def lock
    @vote = Vote.find(params[:vote_id])
    #TEMP
    #unless @vote.user == current_user
    #  redirect_to root_url, notice: "Nicht berechtigt."
    #  return false
    #end
    authorize @vote

    @vote.locked = true
    @vote.user = nil
    @vote.save!

    if @vote.persisted?
      redirect_to voting_vote_url(@voting, @vote), notice: "Deine Stimme wurde gezählt."
    else
      redirect_to root_url, notice: "Fehler. Bitte melde dich bei uns."
    end
  end

  private

  def load_voting
    if params[:voting_id] then @voting = Voting.find(params[:voting_id]) end
  end

  #def load_voting
  #  klass = [Voting].detect { |c| params["#{c.name.underscore}_id"]}
  #  @voting = klass.find(params["#{klass.name.underscore}_id"]) || klass.find(params["#{klass.name.underscore}_id"]) if klass
  #end
end
