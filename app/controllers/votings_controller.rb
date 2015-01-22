class VotingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def index
    @votings = Voting.all
  end

  def new
    authorize :votings, :new?
  end

  def create
    authorize :votings, :create?

    if @voting = Voting.create(voting_params)
      redirect_to @voting
    else
      flash[:notice] = "Ein Fehler ist aufgetreten. Bitte prüfe deine Eingabe."
      render :new
    end
  end

  def show
    @voting = Voting.find(params[:id])
  end

  def voting_params
    params.require(:voting).permit(:title, :description, :start_time, :end_time, :election)
  end
end
