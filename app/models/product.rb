class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items

  validates :stock, :title, :price, :description, :image_url, presence: true

  validates_numericality_of :price
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # def new_arrival
  #   self.category.name == "New arrival"
  # end
end
