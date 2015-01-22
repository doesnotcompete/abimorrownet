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

  def edit
    authorize :votings, :edit?

    @voting = Voting.find(params[:id])
  end

  def update
    @voting = Voting.find(params[:id])
    authorize @voting

    if @voting.update(voting_params)
      redirect_to @voting
    else
      render :edit
    end
  end

  def voting_params
    params.require(:voting).permit(:title, :description, :start_time, :end_time, :election, :interactive)
  end
end
