class VotingOptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
  end

  def create
    unless current_user.admin?
      redirect_to root_url
      return false
    end

    @quote = @voting.voting_options.create(title: params[:voting_option][:title], description: params[:voting_option][:description])

    if @quote.persisted?
      redirect_to @voting
    else
      render :new
    end
  end

  def show
    @option = VotingOption.find(params[:id])
    @vote = Vote.where(user: current_user, voting: @voting)
    @selection = VotedOption.where(vote: @vote, voting_option: @option)
  end

  def select
    @option = VotingOption.find(params[:option_id])
    @vote = Vote.find_by(user: current_user, voting: @voting)
    @selections = VotedOption.where(vote: @vote)

    if @selections.count >= @vote.max_choices
      redirect_to voting_vote_path(@voting, @vote), notice: "Du kannst keine weiteren Optionen wählen."
      return false
    end

    if @vote.present?
      @voted = VotedOption.create(vote: @vote, voting_option: @option)
      if @voted.persisted?
        flash[:notice] = "Du hast eine Option gewählt."
        redirect_to voting_vote_path(@voting, @vote)
      else
        redirect_to voting_vote_path(@voting, @vote), notice: 'Fehler beim Speichern. Bitte melde dich bei uns.'
      end
    else
      flash[:notice] = "Du bist nicht stimmberechtigt."
      redirect_to :root_url
    end
  end

  def deselect
    option = VotingOption.find(params[:option_id])
    vote = Vote.find_by(user: current_user, voting: @voting)
    @voted = VotedOption.find_by(vote: vote, voting_option: option)

    if @voted.present?
      @voted.destroy
      redirect_to voting_vote_path(@voting, vote), notice: "Option abgewählt."
    else
      redirect_to voting_vote_path(@voting, vote), notice: "Fehler"
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
