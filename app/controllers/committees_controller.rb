class CommitteesController < ApplicationController
  before_filter :authenticate_user!
  around_filter :catch_errors

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

    if @committee.update(committee_params)
      redirect_to @committee
    else
      render :edit
    end
  end

  def create
    authorize :committee, :create?

    if @committee = Committee.create(committee_params)
      redirect_to committee_url(@committee)
    else
      redirect_to new_committee_url, alert: "Fehler beim Speichern."
    end
  end

  def show
    @committee = find_committee
    authorize @committee
  end

  def destroy
    @committee = find_committee
    authorize @committee

    @committee.destroy
    redirect_to committees_path
  end

  private

  def find_committee
    Committee.friendly.find(params[:id]) || Committee.find(params[:id])
  end

  def committee_params
    params.require(:committee).permit(:title, :description)
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to committees_url, alert: "Komitee nicht gefunden."
  rescue Pundit::NotAuthorizedError
    redirect_to committees_url, alert: "Diese Aktion ist nur Administratoren erlaubt."
  end
end
