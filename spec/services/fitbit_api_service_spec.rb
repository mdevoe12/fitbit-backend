require 'rails_helper'

RSpec.describe FitbitApiService do
  context "fitbit API connection" do
    it "creates new instance of FitbitApiService" do
      user = User.create(token: "123")

      service = FitbitApiService.new(user)

      expect(service.conn).to be_instance_of(Faraday::Connection)
      expect(service.user).to eq(user)
    end
  end
end
