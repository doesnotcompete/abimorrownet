class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
  end

  def new
  end

  def create
    User.transaction do
      @profile = Profile.create(params[:profile])
      current_user.profile = @profile
      current_user.save!
    end
    redirect_to profile_url(@profile)
  end
end
