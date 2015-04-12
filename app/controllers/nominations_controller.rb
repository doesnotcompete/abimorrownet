class NominationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  before_filter :load_award

  def show
    @nomination = Nomination.find(params[:id])
    @votes = (@award.voting.count_users[@nomination.tier - 1][1] rescue 0)
    @total_votes = @award.voting.votes.count
  end

  def accept
    @nomination = Nomination.find(params[:nomination_id])
    authorize @nomination
    @nomination.accepted = true
    @nomination.save

    flash[:notice] = "Wahl angenommen."
    redirect_to [@award.voting, @award, @nomination]
  end

  def dismiss
    @nomination = Nomination.find(params[:nomination_id])
    authorize @nomination
    @nomination.accepted = false
    @nomination.save

    flash[:notice] = "Wahl abgelehnt."
    redirect_to [@award.voting, @award, @nomination]
  end

  def reset
    @nomination = Nomination.find(params[:nomination_id])
    authorize @nomination
    @nomination.accepted = nil
    @nomination.save

    flash[:notice] = "Wahl zurückgesetzt."
    redirect_to [@award.voting, @award, @nomination]
  end

  private

  def load_award
    if params[:award_id] then @award = Award.find(params[:award_id]) end
  end
end
