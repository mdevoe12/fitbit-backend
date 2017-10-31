Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['FITBIT_CLIENT_ID'], ENV["FITBIT_CLIENT_SECRET"],
  scope: "profile activity sleep heartrate location nutrition settings social weight",
  provider_ignores_state: true
end
