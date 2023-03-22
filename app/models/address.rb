class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :line1, :city, :state, :zip, presence: true
  validates :zip, numericality: { only_integer: true }, length: { maximum: 5 }
  validates :state, length: { maximum: 2 }, format: { with: /([A-Z])/, message: "must have only two capital letters" }

  def to_s
    [line1, line2, city, state, zip].select(&:present?).join(', ')
  end
end
