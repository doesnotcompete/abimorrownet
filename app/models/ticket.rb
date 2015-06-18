class Ticket < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  has_many :ticket_preference_associations
  accepts_nested_attributes_for :ticket_preference_associations
  
  def create_pdf
    pdftk = PdfForms.new('/usr/bin/pdftk')
    template_path = "#{Rails.root}/tickets/tmpl.pdf"
    ticket_path = "#{Rails.root}/tickets/#{self.number}.pdf"
    pdftk.fill_form template_path, ticket_path, {nummer: "#{self.number}---", name: self.order.name, anzahl: self.product.max_people, personen: self.people * ", "}, :flatten => true
  end
  
  def ticket_path
    "#{Rails.root}/tickets/#{self.number}.pdf"
  end
end
