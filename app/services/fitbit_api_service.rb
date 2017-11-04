class FitbitApiService

  attr_reader :conn,
              :uid

  def initialize(user)
    @conn = Faraday.new("https://api.fitbit.com") do |faraday|
        faraday.headers["Authorization"] = "Bearer #{user.token}"
        faraday.adapter Faraday.default_adapter
      end
    @uid = user.uid
  end

  def self.get_sleep_info(user)
    # new(user).get_sleep_info(user)
    new(user).get_body_info(user)
  end

  def get_sleep_info(user)
    response = @conn.get("/1.2/user/3G2M4H/sleep/list.json?afterDate=2017-10-01&sort=desc&offset=0&limit=30")
    sleep_info = JSON.parse(response.body, symbolize_names: true)[:sleep]
    sleep_info.each do |raw_info|
      sleep_nest = raw_info[:levels][:summary]
      user.sleeps.create(date_of_wakeup: raw_info[:dateOfSleep],
                           deep_minutes: sleep_nest[:deep][:minutes],
                          light_minutes: sleep_nest[:light][:minutes],
                            rem_minutes: sleep_nest[:rem][:minutes],
                           wake_minutes: sleep_nest[:wake][:minutes])
    end
  end

  def get_activity_info(user)
    response = @conn.get("/1/user/3G2M4H/activities/activityCalories/date/today/30d.json")
    activity_info = JSON.parse(response.body)["activities-activityCalories"]
    activity_info.each do |raw_info|
      user.activities.create(date: raw_info["dateTime"],
              active_calories_out: raw_info["value"])
    end

  end

  def get_heart_info(user)
    response = @conn.get("/1/user/3G2M4H/activities/heart/date/today/30d.json")
    heart_info = JSON.parse(response.body)["activities-heart"]
    heart_info.each do |raw_info|
      user.hearts.create(date: raw_info["dateTime"],
           resting_heart_rate: raw_info["value"]["restingHeartRate"])
    end
  end

  def get_body_info(user)
    response = @conn.get("/1/user/3G2M4H/body/log/weight/date/2017-11-02/30d.json")
    body_info = JSON.parse(response.body)["weight"]
    body_info.each do |raw_info|
      user.bodies.create(date: raw_info["date"],
                     body_fat: raw_info["fat"],
                          bmi: raw_info["bmi"],
                       weight: raw_info["weight"])
    end
  end


end
