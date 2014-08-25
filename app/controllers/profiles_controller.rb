class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  around_filter :catch_errors

  respond_to :html, :json

  def show
    @profile = Profile.friendly.find(params[:id]) || Profile.find(params[:id])
    respond_with @profile
  end

  def new
  end

  def index
    @profiles = Profile.all
    respond_to do |format|
      format.html
      format.json { render json: ProfileDatatable.new(view_context) }
    end
  end

  def edit
    if @profile = Profile.find(params[:id])
      authorize @profile
    else
      redirect_to root_url, alert: "Profil nicht gefunden."
    end
  end

  def update
    @profile = Profile.find(params[:id])
    authorize @profile

    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  def create
    authorize :profile, :create?

    Profile.transaction do
      if @profile = Profile.create(profile_params)
        current_user.profile = @profile
        current_user.save!
      else
        return false
      end
    end

    if @profile.persisted?
      redirect_to profile_url(@profile)
    else
      redirect_to new_profile_url
    end
  end


  private

  def profile_params
    params.require(:profile).permit(:id, :first_name, :last_name, :about)
  end

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "Profil nicht gefunden."
  rescue Pundit::NotAuthorizedError
    redirect_to root_url, alert: "Du kannst kein weiteres Profil anlegen."
  end

end
