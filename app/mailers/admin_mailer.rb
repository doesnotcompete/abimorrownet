class AdminMailer < ActionMailer::Base
  default from: "hallo@abimorrow.net"

  def notify_admin_of_become(issuer, logged_in_as)
    @issuer = issuer
    @user = logged_in_as
    mail(to: 'kevin@quosh.net', subject: 'NOTICE: abimorrownet - Fremdanmeldung')
  end
end
