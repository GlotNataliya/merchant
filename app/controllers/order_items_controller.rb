class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[ plus minus ]
  before_action :set_order_item, only: %i[ edit update destroy plus minus ]
  before_action :load_order, only: %i[ create update ]

  def show
    # if current_user.present?
    #   redirect_to confirm_order_path(@order)
    # else
    #   redirect_to order_url(@order)
    # end
  end

  def edit; end

  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])

    @order_item.update(quantity: @order_item.quantity + 1)

    if @order_item.save
      redirect_to root_path, notice: 'Successfully added product to cart.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:order_item][:quantity].to_i.zero?
      @order_item.destroy
      redirect_to order_url(@order), notice: "Order item was successfully destroyed."
    elsif @order_item.update(order_item_params)
      redirect_to order_url(@order), notice: "Order item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item.destroy

    redirect_to order_url, notice: "Order item was successfully destroyed."
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
    @order = current_user.orders.find_by(id: session[:order_id])
  end

  def load_order
    if current_user.present?
      @order = current_user.orders.last ||
      @order = Order.find_or_initialize_by(id: session[:order_id], user_id: current_user.id, status: "unsubmitted")
      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    else
      redirect_to new_user_session_path, notice: "Please have registration"
    end
  end
end
