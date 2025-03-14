# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @order = current_user.orders.last if current_user.present?

    @order_items = @order&.order_items

    @photo_fruits_and_vegetables = Unsplash::Photo.random(query: "fruits and vegetables")
    @photo_cuisine = Unsplash::Photo.random(query: "cuisine")
    @photo_coffee = Unsplash::Photo.random(query: "coffee")
    @photo_pastries = Unsplash::Photo.random(query: "pastries")

    @photo_carousel_food = Unsplash::Photo.random(query: "food")
    @photo_carousel_delivery = Unsplash::Photo.random(query: "delivery")
    @photo_carousel_payment = Unsplash::Photo.random(query: "payment")

    @photo_desserts = Unsplash::Photo.random(query: "desserts")
    @photo_seafood = Unsplash::Photo.random(query: "seafood")
    @photo_fresh_vegetables = Unsplash::Photo.random(query: "Fresh vegetables")
    @photo_berries = Unsplash::Photo.random(query: "berries")
    @photo_meat = Unsplash::Photo.random(query: "meat")
    @photo_homemade_baking = Unsplash::Photo.random(query: "homemade baking")

    suggestions_categories_of_products_feedback_and_review
  end

  private

  def suggestions_categories_of_products_feedback_and_review
    products = Product.all
    @new_arrivals = products.includes(:category).where(categories: { name: "New arrival" })
    @juices = products.includes(:category).where(categories: { name: "Water, juices, drinks" })
    @nuts = products.includes(:category).where(categories: { name: "Nuts" })
    @feedback = Feedback.new
    @reviews = Review.all
  end
end
