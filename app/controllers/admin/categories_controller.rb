# frozen_string_literal: true

module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[edit update destroy]
    before_action :check_if_admin
    respond_to :html, :turbo_stream

    def index
      @categories = Category.all.order(created_at: :desc)
    end

    def new
      @category = Category.new
    end

    def edit; end

    def create
      @category = Category.new(category_params)

      if @category.save
        respond_with @category, location: -> { admin_categories_path }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @category.update(category_params)
        respond_with @category, location: -> { admin_categories_path }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category.destroy

      respond_with @category, location: -> { admin_categories_path }
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
