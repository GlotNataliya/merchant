Unsplash.configure do |config|
  config.application_access_key = Rails.application.credentials.dig(:unsplash, :access_key)
  config.application_secret = Rails.application.credentials.dig(:unsplash, :secret_key)
  config.application_redirect_uri = "http://localhost:3000/auth/callback"
  config.utm_source = "merchant"
end
