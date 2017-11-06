require 'rails_helper'

RSpec.describe FitbitApiService do

  RSpec.configure do |config|
    config.mock_with :rspec
  end
  context "fitbit API connection" do
    it "creates new instance of FitbitApiService" do
      user = User.create(token: "123")

      service = FitbitApiService.new(user)

      expect(service.conn).to be_instance_of(Faraday::Connection)
      expect(service.user).to eq(user)
    end

    it "test import_thirty_day_data" do
      user = User.create(token: "123")
      service = FitbitApiService.new(user)
      # allow(service).to receive(get_sleep_info).and_return(true)
      # allow(service).to receive(get_activity_info).and_return(true)
      # allow(service).to receive(get_heart_info).and_return(true)
      # allow(service).to receive(get_body_info).and_return(true)
      allow(service).to receive(import_thirty_day_data).and_return(true)

    end
  end
end
