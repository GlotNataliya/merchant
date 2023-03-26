class PagesController < ApplicationController
  before_action :set_order_items, only: %i[ about contact delivery payment personal_account blog]

  def about; end

  def contact; end

  def delivery; end

  def payment; end

  def personal_account; end

  def blog; end

  private

  def set_order_items
    @order = current_user.orders.last if current_user.present?
    @order_items = @order&.order_items
  end
end
