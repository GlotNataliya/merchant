class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  def index
    products = Product.all

    @order = current_user.orders.last if current_user.present?

    @new_arrivals = products.includes(:category).where(categories: { name: "New arrival" })
    @juices = products.includes(:category).where(categories: { name: "Water, juices, drinks" })
    @nuts = products.includes(:category).where(categories: { name: "Nuts" })

    @feedback = Feedback.new
    @reviews = Review.all
  end

  # def show
  # end

  # private

  # def set_product
  #   @product = Product.find(params[:id])
  # end
end
