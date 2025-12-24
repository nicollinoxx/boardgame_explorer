BggRemote.configure do |config|
  config.token = Rails.application.credentials.dig(:bgg, :api_token)
end
