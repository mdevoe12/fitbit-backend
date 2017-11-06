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

    it "returns sleep_url" do
      user = User.create(token: "123")
      service = FitbitApiService.new(user)

      result = service.sleep_url
      expected = "/1.2/user//sleep/list.json?afterDate=2017-10-06&sort=desc&offset=0&limit=30"

      expect(result).to eq(expected)
    end

    it "returns activity_url" do
      @user = User.create(token: "123", uid: '311')
      service = FitbitApiService.new(@user)

      result = service.activity_url
      expected = "/1/user/#{@user.uid}/activities/activityCalories/date/today/30d.json"

      expect(result).to eq(expected)
    end

    it "returns heart_url" do
      @user = User.create(token: "123", uid: '311')
      service = FitbitApiService.new(@user)

      result = service.heart_url
      expected = "/1/user/#{@user.uid}/activities/heart/date/today/30d.json"

      expect(result).to eq(expected)
    end

    it "returns body_url" do
      @user = User.create(token: "123", uid: '311')
      service = FitbitApiService.new(@user)
      current_day = Date.today

      result = service.body_url
      expected = "/1/user/#{@user.uid}/body/log/weight/date/#{current_day}/30d.json"

      expect(result).to eq(expected)
    end
  end
end
