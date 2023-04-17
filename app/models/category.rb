class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end
end
