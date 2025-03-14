# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy

  validates :stock, :title, :price, :description, :image, presence: true

  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  mount_uploader :image, ImageUploader

  monetize :price, as: :price_cents

  def show_currency(currency)
    { "usd" => "$", "eur" => "€", "rub" => "₽", "pln" => "zł", "byn" => "br", "uah" => "₴" }.fetch(currency)
  end

  def to_s
    title
  end

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
      product.adjustable_quantity enabled: true, minimum: 1, maximum: 10
    end
  end

  after_create do
    product = Stripe::Product.create(name: title)
    price = Stripe::Price.create(product:, unit_amount: self.price.to_i, currency:)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[currency price title]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category order_items]
  end
end
