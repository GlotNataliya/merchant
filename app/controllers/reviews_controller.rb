class ReviewsController < ApplicationController
  def new
    if current_user.present?
      @review = current_user.reviews.build
    else
      render :notice
    end
  end

  def create
    @review = current_user.reviews.build(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to root_path, notice: "Review was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @address.update(review_params)
      redirect_to root_path, notice: "Review was successfully updated."
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
