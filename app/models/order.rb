class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned, class_name: 'User'

  has_many :order_position, dependent: :destroy
  has_many :products, through: :order_position
  
  has_one :ticket, dependent: :destroy
  has_one :delivery_address, dependent: :destroy

  accepts_nested_attributes_for :products

  validates :email, presence: true

  def sum
    @total = 0
    @positions = OrderPosition.where(order: self)
    @positions.each do |pos|
      @total += pos.product.price
    end

    if self.shipped then @total += 0.00 end

    return @total
  end
  
  def self.plan_delivery_for_all(product_id)
    @orders = Order.joins(:order_position).merge(OrderPosition.where("product_id = ?", product_id))
    @orders.each do |o|
      o.token = SecureRandom.hex(6)
      o.save
      OrderMailer.plan_delivery(o).deliver
    end
  end
end
