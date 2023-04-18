# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[destroy plus minus]
  before_action :set_order_item, only: %i[edit destroy plus minus]
  before_action :load_order, only: %i[create]
  before_action :authenticate_user!
  respond_to :html, :turbo_stream

  def edit; end

  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])

    @order_item.update(quantity: @order_item.quantity + 1)

    if @order_item.save
      respond_with @order_item, location: -> { root_path }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item.destroy

    respond_with @order_item, location: -> { order_path }
  end

  def plus
    @order_item.update(quantity: @order_item.quantity + 1)
    redirect_to @order
  end

  def minus
    @order_item.update(quantity: @order_item.quantity - 1)
    redirect_to @order
  end

  private

  def set_order_item
    @order_item = @order.order_items.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id, :quantity)
  end

  def set_order
    @order = current_user.orders.find_by(id: current_user.orders.last.id)
  end

  def load_order
    if current_user.present?
      find_or_initialize_order
    else
      redirect_to new_user_session_path
    end
  end

  def find_or_initialize_order
    @order = current_user.orders.last ||
    Order.find_or_initialize_by(id: session[:order_id], user_id: current_user.id, status: "unsubmitted")

    return unless @order.new_record?

    @order.save!
    session[:order_id] = @order.id
  end
end
