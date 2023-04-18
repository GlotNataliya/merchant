# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[edit update destroy]
    before_action :check_if_admin

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

      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_products_url, notice: "Product was successfully created." }
          format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_products_url, notice: "Product was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @product.destroy

      respond_to do |format|
        format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
        format.turbo_stream
      end
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
