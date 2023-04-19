# frozen_string_literal: true

module Stripe
  class SessionCreator
    def initialize(user, products, success_url, confirm_order_url)
      @user = user
      @products = products
      @success_url = success_url
      @confirm_order_url = confirm_order_url
    end

    def call
      create_stripe_order
    end

    private

    def create_stripe_order
      Stripe::Checkout::Session.create({
                                         customer: user.stripe_customer_id,
                                         payment_method_types: ["card"],
                                         line_items: products.map { |product| product.to_builder.attributes! },
                                         allow_promotion_codes: true,
                                         mode: "payment",
                                         success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
                                         cancel_url: confirm_order_url
                                       })
    end

    attr_reader :user, :products, :success_url, :confirm_order_url
  end
end
