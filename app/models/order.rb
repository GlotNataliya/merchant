class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :address, optional: true

  delegate :quantity, to: :order_items

  has_many :order_items, dependent: :destroy

  def total
    order_items.map(&:subtotal).sum
  end
end
