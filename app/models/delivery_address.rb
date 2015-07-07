class DeliveryAddress < ActiveRecord::Base
  belongs_to :order
  
  validates :kind, presence: true
end
