# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name]
  end
end
