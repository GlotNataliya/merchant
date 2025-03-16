class ProductsController < ApplicationController
  def index
    @order = current_user.orders.last if current_user.present?

    @order_items = @order&.order_items

    @topic_images = {}

    getting_unsplash_photos

    suggestions_categories_of_products_feedback_and_review
  end

  private

  def suggestions_categories_of_products_feedback_and_review
    products = Product.all
    @new_arrivals = products.includes(:category).where(categories: { name: "New arrival" })
    @juices = products.includes(:category).where(categories: { name: "Water, juices, drinks" })
    @nuts = products.includes(:category).where(categories: { name: "Nuts" })
    @feedback = Feedback.new
    @reviews = Review.all
  end

  def getting_unsplash_photos
    UnsplashService::TOPICS.each do |topic|
      @topic_images[topic] = UnsplashService.random_image(topic)

      size_for_photo_news = "&w=328&h=328&fit=crop&crop=entropy"
      @photo_fruits_and_vegetables = @topic_images[topic] + size_for_photo_news if topic == "fruits and vegetables"
      @photo_cuisine = @topic_images[topic] + size_for_photo_news if topic == "cuisine"
      @photo_coffee = @topic_images[topic] + size_for_photo_news if topic == "coffee"
      @photo_pastries = @topic_images[topic] + size_for_photo_news if topic == "pastries"

      size_for_photo_carousel = "&w=1400&h=810&fit=crop&crop=entropy"
      @photo_carousel_food = @topic_images[topic] + size_for_photo_carousel if topic == "food"
      @photo_carousel_delivery = @topic_images[topic] + size_for_photo_carousel if topic == "delivery"
      @photo_carousel_payment = @topic_images[topic] + size_for_photo_carousel if topic == "payment"

      size_for_photo_banners_1 = "&w=690&h=345&fit=crop&crop=entropy"
      @photo_desserts = @topic_images[topic] + size_for_photo_banners_1 if topic == "desserts"
      @photo_seafood = @topic_images[topic] + size_for_photo_banners_1 if topic == "seafood"

      size_for_photo_banners_2 = "&w=451&h=225&fit=crop&crop=entropy"
      @photo_fresh_vegetables = @topic_images[topic] + size_for_photo_banners_2 if topic == "Fresh vegetables"
      @photo_berries = @topic_images[topic] + size_for_photo_banners_2 if topic == "berries"
      @photo_meat = @topic_images[topic] + size_for_photo_banners_2 if topic == "meat"

      @photo_homemade_baking = @topic_images[topic] + "&w=1408&h=318&fit=crop&crop=entropy" if topic == "homemade baking"
    end
  end
end
