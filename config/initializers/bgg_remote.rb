Rails.application.config.after_initialize do
  BggRemote.configure do |config|
    config.token = Rails.application.credentials.dig(:bgg, :api_token).presence || ""
  end
end
