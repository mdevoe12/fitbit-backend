FitbitAPI.configure do |config|
  config.client_id       = ENV['FITBIT_CLIENT_ID']
  config.client_id       = ENV['FITBIT_CLIENT_SECRET']
  config.snake_case_keys = true
  config.symbolize_keys  = true
end
