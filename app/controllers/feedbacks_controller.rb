class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.request = request
    if @feedback.deliver
      flash.now[:success] = 'Message sent!'
      redirect_to root_path
    else
      flash.now[:error] = 'Could not send message'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :message, :term)
  end
end
