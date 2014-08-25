class CommitteesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @committees = Committee.all
  end

  def new

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

  private

  def find_committee
    Committee.friendly.find(params[:id]) || Committee.find(params[:id])
  end

  def committee_params
    params.require(:committee).permit(:title, :description)
  end
end
