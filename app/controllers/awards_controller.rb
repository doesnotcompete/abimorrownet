class AwardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_voting

  def create
    authorize :award, :create?

    if @award = Award.create(title: params[:awards][:title], tiers: params[:awards][:tiers], voting: @voting)
      redirect_to [@voting, @award]
    else
      redirect_to new_award_url, alert: "Fehler beim Speichern."
    end
  end

  def show
    @award = Award.find(params[:id])
    @nominations = @award.nominations
  end

  def destroy
    @award = Award.find(params[:id])
    authorize @award

    @award.destroy
    redirect_to @voting
  end

  def nominate
    @award = Award.find(params[:award_id])

    @winners = @voting.count_users

    @award.tiers.times do |i|
      user = User.find(@winners[i][0])
      nom = @award.nominations.create(tier: i+1, user: user, accepted: nil)
      if user.notify then
        NotificationMailer.nominated(nom).deliver
      end
    end
    redirect_to [@voting, @award]
  end

  private

  def load_voting
    if params[:voting_id] then @voting = Voting.find(params[:voting_id]) end
  end
end
