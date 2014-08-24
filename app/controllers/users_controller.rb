class UsersController < ApplicationController
  def remove_association
    current_user.remove_association
    redirect_to root_url, notice: "Die Verknüpfung wurde aufgehoben."
  end
end
