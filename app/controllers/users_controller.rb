class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!
  
  def remove_association
    current_user.remove_association
    redirect_to root_url, notice: "Die Verknüpfung wurde aufgehoben."
  end
end
