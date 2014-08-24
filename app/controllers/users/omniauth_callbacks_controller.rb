class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.present?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    elsif current_user.present?
      current_user.associate_identity(request.env["omniauth.auth"])
      redirect_to root_url, notice: "Wir haben deinen Account mit Facebook verknüpft."
    else
      redirect_to root_url, notice: "Wir konnten deinen Account nicht zuordnen."
    end
  end
end
