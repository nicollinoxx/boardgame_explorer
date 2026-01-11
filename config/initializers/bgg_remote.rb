return if ENV["SECRET_KEY_BASE_DUMMY"].present?

Rails.application.config.after_initialize do
  BggRemote.configure do |config|
    config.token = Rails.application.credentials.dig(:bgg, :api_token)
  end
end
