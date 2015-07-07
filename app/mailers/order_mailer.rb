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

  def reminder(order)
    @order = order
    mail(to: @order.email, subject: 'Zahlungserinnerung')
  end
  
  def plan_delivery(order)
    @order = order
    mail(to: @order.email, subject: 'Zustellung planen: deine Bestellung ist versandbereit')
  end
  
  def ticket_created(ticket)
    @ticket = ticket
    attachments['Ticket.pdf'] = File.read(@ticket.ticket_path)
    mail(to: @ticket.order.email, subject: 'Deine Eintrittskarte für den Abiball')
  end
end
