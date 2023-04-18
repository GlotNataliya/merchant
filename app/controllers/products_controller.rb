# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show ]

  def index
    @order = current_user.orders.last if current_user.present?

    @order_items = @order&.order_items

    suggestions_categories_of_products_feedback_and_review
  end

  # def show
  # end

  private

  def suggestions_categories_of_products_feedback_and_review
    products = Product.all
    @new_arrivals = products.includes(:category).where(categories: { name: "New arrival" })
    @juices = products.includes(:category).where(categories: { name: "Water, juices, drinks" })
    @nuts = products.includes(:category).where(categories: { name: "Nuts" })
    @feedback = Feedback.new
    @reviews = Review.all
  end

  # def set_product
  #   @product = Product.find(params[:id])
  # end
end
