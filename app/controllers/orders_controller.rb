class OrdersController < ApplicationController
  before_action :set_order, only: %i[ edit update destroy confirm]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.last

    @addresses = current_user&.addresses

    @order_items = @order.order_items.order(created_at: :desc)
    # if current_user.present?
    #   redirect_to confirm_order_path(@order)
    # else
    #   redirect_to order_url(@order)
    # end
  end

  def new
    @order = current_user.orders.build
  end

  def edit
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      redirect_to order_url(@order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params.merge(status: 'submitted'))
      session[:order_id] = nil
      redirect_to confirm_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy

    redirect_to products_path, notice: "Order was successfully destroyed."
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
