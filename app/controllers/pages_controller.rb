class PagesController < ApplicationController
  before_action :set_order_items, only: %i[ about contact ]

  def about; end

  def contact; end

  private

  def set_order_items
    @order = current_user.orders.last if current_user.present?
    @order_items = @order.order_items
  end
end
