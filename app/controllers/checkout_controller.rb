# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    order = current_user.orders.last
    order_items = order&.order_items
    @products = order_items.map(&:product)

    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  payment_method_types: ["card"],
                                                  line_items: @products.map do |product|
                                                                product.to_builder.attributes!
                                                              end,
                                                  allow_promotion_codes: true,
                                                  mode: "payment",
                                                  success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                  cancel_url: confirm_order_url(id: order.id)
                                                })
    redirect_to @session.url, allow_other_host: true
  end

  def success
    order = current_user.orders.last
    if params[:session_id].present?
      order.destroy
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"] })
      @session_with_expand.line_items.data.each do |line_item|
        product = Product.find_by(stripe_product_id: line_item.price.product)
      end
    else
      redirect_to cancel_url, alert: "No info to display"
    end
  end

  def cancel; end
end
