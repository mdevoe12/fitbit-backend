require 'rails_helper'

RSpec.describe FitbitTokenService do
  context "Fitbit connection" do
    it "returns a valid connection" do
      VCR.use_cassette("/services/fitbit_token_service_spec.rb") do
        connection = FitbitTokenService.connect("123")

        expect(connection.params["clientID"]).to eq(ENV["FITBIT_CLIENT_ID"])
        expect(connection.headers["Authorization"]).to eq("Basic MjJDS0ROOjg2YTU4YzRmNDFmY2UxNTkzMTE2MmY5MmM1MzZkOTJk")
      end
    end

    it "can send a message to get a token" do
      VCR.use_cassette("/services/fitbit_token_service_spec.rb") do
        service = FitbitTokenService.get_token("321")

        expect(service.env['method']).to eq(:post)
      end
    end
  end
end
