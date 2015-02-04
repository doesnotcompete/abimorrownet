class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned, class_name: 'User'

  has_many :order_position
  has_many :products, through: :order_position

  accepts_nested_attributes_for :products

  validates :email, presence: true

  def sum
    @total = 0
    @positions = OrderPosition.where(order: self)
    @positions.each do |pos|
      @total += pos.product.price
    end

    if self.shipped then @total += 5.45 end

    return @total
  end
end
