class VotingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  respond_to :html, :json

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
    if @voting.election? then
      @results = @voting.count_users
      @awards = @voting.awards
    end
    @all_votes = @voting.votes
    @locked_votes = 0
    @all_votes.where(locked: true).each do |vote|
      @locked_votes += vote.voted_options.count
    end

    @participation = @all_votes.where(locked: true).count.to_f / @all_votes.count.to_f
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

  def results
    @voting = Voting.find(params[:voting_id])
    authorize @voting

    @results = @voting.voting_options
    if @voting.election?
      @results = @voting.count_users
      @label = []
      @series = []
      @results.each do |resultset|
        @label << User.find(resultset[0]).full_name
        @series << resultset[1]
      end
    else
      @label = @results.pluck(:title)
      @series = []
      @results.each do |option|
        @series << option.votes.where(locked: true).count
      end
    end

    respond_to do |format|
      format.html { render json: {labels: @label, series: [@series]} }
      format.json { render json: {labels: @label, series: [@series]} }
    end
  end

  def voting_params
    params.require(:voting).permit(:title, :description, :start_time, :end_time, :election, :interactive, :premium)
  end
end
