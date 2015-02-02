class UsersController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    user = User.find(params[:id])
    authorize user

    user.destroy!

    redirect_to :back, notice: "Benutzer gelöscht."
  end

  def become
    return unless current_user.admin?
  end

  def become_user
    return unless current_user.admin?
    @login = User.find(params[:users][:user])

    AdminMailer.notify_admin_of_become(current_user, @login)

    sign_in(:user, @login)

    redirect_to root_url # or user_root_url
  end

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
