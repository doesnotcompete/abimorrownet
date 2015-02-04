class OrderMailer < ActionMailer::Base
  default from: "\"KGS Rastede - Abiturjahrgang 2015\" <hallo@abimorrow.net>"

  def order_confirmation(order)
    @order = order
    mail(to: @order.email, subject: 'Bestätigung deiner Bestellung bei Abimorrowland')
  end

  def order_paid(order)
    @order = order
    mail(to: @order.email, subject: 'Zahlung bestätigt')
  end
end
