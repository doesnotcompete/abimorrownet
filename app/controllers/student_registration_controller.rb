class StudentRegistrationController < ApplicationController
  def new
  end

  def create
    if @registration = StudentRegistration.create(user_params).valid?
      redirect_to finished_registration_url
    else
      flash[:notice] = "Fehler beim Eintragen. Bitte stelle sicher, dass du alle Felder ausgefüllt hast und nicht bereits eingetragen bist."
      render :new
      flash.clear()
    end
  end

  def finished
  end

  def user_params
    params.require(:student_registration).permit(:email, :first_name, :last_name)
  end
end
