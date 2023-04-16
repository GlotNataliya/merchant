class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def subtotal
    product.price_cents * quantity unless product.nil?
  end
end
