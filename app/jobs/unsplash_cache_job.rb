class UnsplashCacheJob < ApplicationJob
  queue_as :default

  def perform
    UnsplashService::TOPICS.each do |topic|
      UnsplashService.random_image(topic)
    end
  end
end
