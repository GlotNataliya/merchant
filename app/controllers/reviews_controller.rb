# frozen_string_literal: true

class ReviewsController < ApplicationController
  respond_to :html, :turbo_stream

  def new
    if current_user.present?
      @review = current_user.reviews.build
    else
      render :notice
    end
  end

  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      respond_with @review, location: -> { root_path }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(review_params)
      respond_with @review, location: -> { root_path }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def notice; end

  private

  def review_params
    params.require(:review).permit(:description, :user_id)
  end
end
