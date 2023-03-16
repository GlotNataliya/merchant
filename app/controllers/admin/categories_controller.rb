module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ edit update destroy ]
    before_action :check_if_admin

    def index
      @categories = Category.all.order(created_at: :desc)
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to admin_products_url, notice: "Category was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to admin_categories_url, notice: "Category was successfully updated." }
          format.turbo_stream
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @category.destroy

      respond_to do |format|
        format.html { redirect_to admin_categories_url, notice: "Category was successfully destroyed." }
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def check_if_admin
      redirect_to root_path unless current_user&.admin?
    end
  end
end
