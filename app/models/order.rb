# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true
  has_many :order_items, dependent: :destroy

  def total
    order_items.map(&:subtotal).compact.inject(:+)
  end
end
