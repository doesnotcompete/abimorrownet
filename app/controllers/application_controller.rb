class ApplicationController < ActionController::Base
  include Pundit
  require 'csv'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  around_filter :catch_errors

  def ensure_profile!
    redirect_to new_profile_path unless current_user.profile
  end

  def find_friendly(model)
    model.friendly.find(params[:id]) || model.find(params[:id])
  end

  private

  def catch_errors
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "Ressource nicht gefunden."
  rescue Pundit::NotAuthorizedError
    redirect_to root_url, alert: "Diese Aktion ist nur Administratoren erlaubt."
  end
end
