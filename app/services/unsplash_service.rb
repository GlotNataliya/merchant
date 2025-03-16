class UnsplashService
  TOPICS = [
    "fruits and vegetables", "cuisine", "coffee", "pastries",
    "food", "delivery", "payment", "desserts", "seafood",
    "Fresh vegetables", "berries", "meat", "homemade baking"
  ].freeze

  CACHE_TTL = 1.hour.to_i

  class << self
    def random_image(topic)
      cached_data = $redis.get(cache_key(topic))

      return cached_data if cached_data

      fetch_and_cache_image(topic)
    end

    private

    def fetch_and_cache_image(topic)
      photo = Unsplash::Photo.random(query: topic)
      return nil unless photo && photo.urls && photo.urls.raw

      $redis.setex(cache_key(topic), CACHE_TTL, photo.urls.raw)
      photo.urls.raw
    rescue => e
      Rails.logger.error "Unsplash Error: #{e.message}"
      nil
    end

    def cache_key(topic)
      "unsplash:#{topic.downcase.gsub(/\s+/, '_')}"
    end
  end
end
