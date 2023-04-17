class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items

  validates :stock, :title, :price, :description, :image_url, presence: true

  validates_numericality_of :price
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  mount_uploader :image, ImageUploader

  monetize :price, as: :price_cents

  def show_currency(currency)
    { 'usd' => '$', 'eur' => '€', 'rub' => '₽', 'pln' => 'zł', 'byn' => 'br', 'uah' => '₴' }.fetch(currency)
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
    price = Stripe::Price.create(product: product, unit_amount: self.price.to_i, currency: self.currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  private

  def self.ransackable_attributes(auth_object = nil)
    ["currency", "price", "title"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items"]
  end
end
