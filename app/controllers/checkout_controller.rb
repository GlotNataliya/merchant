# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    order = current_user.orders.last
    order_items = order&.order_items
    products = order_items.map(&:product)

    session = ::Stripe::SessionCreator.new(current_user, products, success_url, confirm_order_url(id: order.id)).call

    redirect_to session.url, allow_other_host: true
  end

  def success
    order = current_user.orders.last
    order.destroy
    @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"] })
    @session_with_expand.line_items.data.each do |line_item|
      Product.find_by(stripe_product_id: line_item.price.product)
    end
  end

  def cancel; end
end
