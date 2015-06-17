class TicketPreferenceAssociation < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :profile
end
