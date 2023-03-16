class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show ]

  def index
    @products = Product.all

    @order = current_user.orders.last if current_user.present?
    @new_arrivals = @products.select {|i| i.category.name == "New arrival"}.take(6)
    @juices =  @products.select {|i| i.category.name == "Water, juices, drinks"}.take(6)
    @nuts =  @products.select {|i| i.category.name == "Nuts"}.take(6)

    @feedback = Feedback.new
  end

  # def show
  # end

  # private

  # def set_product
  #   @product = Product.find(params[:id])
  # end
end
