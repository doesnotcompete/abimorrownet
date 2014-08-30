class CommitteesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def index
    @committees = Committee.all
  end

  def new

  end

  def edit
    authorize :committee, :edit?

    @committee = find_committee
  end

  def update
    @committee = find_committee
    authorize @committee

    @committee.assign_attributes(committee_params)
    users = User.find(params[:committee][:user_ids].reject! { |c| c.empty? })
    @committee.users = users

    if @committee.save
      redirect_to @committee
    else
      render :edit
    end
  end

  def create
    authorize :committee, :create?

    if @committee = Committee.create(committee_params)
      redirect_to @committee
    else
      redirect_to new_committee_url, alert: "Fehler beim Speichern."
    end
  end

  def show
    @committee = find_friendly(Committee.includes(users: :profile))
    authorize @committee

    @members = @committee.users rescue []
  end

  def destroy
    @committee = find_committee
    authorize @committee

    @committee.destroy
    redirect_to committees_path
  end

  def prepare_participation
    @committee = find_committee
  end

  def participate
    @committee = find_committee
    authorize @committee

    current_user.committees << @committee

    redirect_to @committee, notice: "Herzlichen Glückwunsch! Du nimmst jetzt an diesem Komitee teil."
  end

  def departicipate
    @committee = find_committee
    authorize @committee

    current_user.committees.delete(@committee)

    redirect_to @committee, notice: "Wir haben deine Mitgliedschaft beendet."
  end

  private

  def find_committee
    Committee.friendly.find(params[:id]) || Committee.find(params[:id])
  end

  def committee_params
    params.require(:committee).permit(:title, :description)
  end
end
