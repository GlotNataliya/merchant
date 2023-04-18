# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update destroy confirm]
  before_action :authenticate_user!
  respond_to :html, :turbo_stream

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.last

    @addresses = current_user&.addresses

    @order_items = @order.order_items.order(created_at: :desc)
  end

  def new
    @order = current_user.orders.build
  end

  def edit; end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      respond_with @order, location: -> { order_path(@order) }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params.merge(status: "submitted"))
      redirect_to confirm_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy

    respond_with @order, location: -> { products_path }
  end

  def confirm; end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :status, :address_id)
  end
end
