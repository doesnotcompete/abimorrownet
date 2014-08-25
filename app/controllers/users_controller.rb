class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_profile!

  def list_invited
    authorize :user, :list_invited?
    respond_to do |format|
      format.json { render json: InvitedUserDatatable.new(view_context) }
    end
  end

  def remove_association
    current_user.remove_association
    redirect_to root_url, notice: "Die Verknüpfung wurde aufgehoben."
  end
end
