# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[edit update destroy]
    before_action :check_if_admin
    respond_to :html, :turbo_stream

    def index
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true).order(created_at: :desc)
    end

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new(product_params)

      if @product.save
        respond_with @product, location: -> { admin_products_path }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        respond_with @product, location: -> { admin_products_path }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy

      respond_with @product, location: -> { admin_products_path }
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :price_cents, :description, :image, :currency, :stock,
                                      :category_id)
    end

    def check_if_admin
      redirect_to root_path unless current_user&.admin?
    end
  end
end
