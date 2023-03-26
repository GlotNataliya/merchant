class PagesController < ApplicationController
  before_action :set_order_items, only: %i[ about contact delivery payment]

  def about; end

  def contact; end

  def delivery; end

  def payment; end

  private

  def set_order_items
    @order = current_user.orders.last if current_user.present?
    @order_items = @order.order_items
  end
end
