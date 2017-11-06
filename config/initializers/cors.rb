Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://mdevoe12.github.io/fitbit-front-end-react/'
    resource '*',
      headers: :any,
      methods: %i(get post put patch delete options head)
  end
end
