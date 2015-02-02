class VotingOptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def new
    unless current_user.admin? || @voting.interactive? || @voting.election?
      redirect_to root_url
      return false
    end

    @option = VotingOption.new
  end

  def create
    unless current_user.admin? || @voting.interactive? || @voting.election?
      redirect_to root_url
      return false
    end

    if @voting.voting_options.count > 80
      redirect_to root_url, notice: "Zu viele Optionen!"
      return false
    end

    if @voting.election?
      @user = User.find(params[:voting_option][:user_id])
      @existing_option = VotingOption.find_by(user: @user)
      #@option = @existing_option || @voting.voting_options.create(user: @user)
      if @existing_option.present?
        @option = @existing_option
      else
        @option = @voting.voting_options.create(user: @user)
      end
    else
      @option = @voting.voting_options.create(title: params[:voting_option][:title], description: params[:voting_option][:description])
    end

    if @option.persisted?
      if @voting.election?
        @vote = Vote.find_by(user: current_user, voting: @voting)
        select_option(@option, @vote)
      else
        redirect_to @voting
      end
    else
      render :new
    end
  end

  def destroy
    unless current_user.admin?
      redirect_to root_url
      return false
    end

    @option = VotingOption.find(params[:id])
    unless @option.votes.count > 0
      if @option.destroy
        redirect_to @voting, notice: "Option gelöscht."
      else
        redirect_to @voting, notice: "Fehler beim Löschen."
      end
    else
      redirect_to @voting, notice: "Für diese Option wurde bereits gestimmt."
    end
  end

  def show
    @option = VotingOption.find(params[:id])
    @vote = Vote.where(user: current_user, voting: @voting)
    @selection = VotedOption.where(vote: @vote, voting_option: @option)
  end

  def cleanup
    unless current_user.admin?
      redirect_to root_url
      return false
    end
    
    @options = VotingOption.where(voting: @voting)
    @options.each do |option|
      if option.voted_options.empty?
        option.destroy
      end
    end
    redirect_to @voting, notice: "Nicht zugeordnete Optionen gelöscht."
  end

  def select_option(option, current_vote)
    @selections = VotedOption.where(vote: current_vote)

    if @selections.count >= current_vote.max_choices
      redirect_to voting_vote_path(@voting, current_vote), notice: "Du kannst keine weiteren Optionen wählen."
      return false
    end

    if @vote.present?
      @voted = VotedOption.create(vote: current_vote, voting_option: option)
      if @voted.persisted?
        flash[:notice] = "Du hast eine Option gewählt."
        redirect_to voting_vote_path(@voting, current_vote)
      else
        redirect_to voting_vote_path(@voting, current_vote), notice: 'Fehler beim Speichern. Bitte melde dich bei uns.'
      end
    else
      flash[:notice] = "Du bist nicht stimmberechtigt."
      redirect_to :root_url
    end
  end

  def select
    @option = VotingOption.find(params[:option_id])
    @vote = Vote.find_by(user: current_user, voting: @voting)
    select_option(@option, @vote)
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
