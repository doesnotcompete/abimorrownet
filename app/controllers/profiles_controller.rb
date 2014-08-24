class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  around_filter :catch_not_found

  def show
    @profile = Profile.find(params[:id])
  end

  def new
  end

  def update
    @profile = Profile.find(params[:id])

    authorize @profile
  end

  def patch
    authorize @profile
    if @profile.update(profile_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  def create
    Profile.transaction do
      @profile = Profile.create(profile_params)

      return false unless @profile.valid?

      current_user.profile = @profile
      current_user.save!
    end

    if @profile.persisted?
      redirect_to profile_url(@profile)
    else
      redirect_to new_profile_url
    end
  end


  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :about)
  end

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "Profil nicht gefunden."
  end

end
