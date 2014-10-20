class AnnouncementsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def new
    authorize :announcement, :create?
  end

  def create
    authorize :announcement, :create?

    announcement = Announcement.create(announcement_params)

    if announcement.persisted?
      redirect_to root_url
    else
      flash[:notice] = "Fehler beim Speichern."
      render :new
    end
  end

  def index
    @announcements = Announcement.all
  end

  def destroy
    @announcement = Announcement.find(params[:id])

    authorize @announcement
    @announcement.destroy!
    redirect_to root_url, notice: "Ankündigung gelöscht."
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :text, :file, :present)
  end
end
