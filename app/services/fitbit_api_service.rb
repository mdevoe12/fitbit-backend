class FitbitApiService

  attr_reader :conn,
              :uid

  def initialize(user)
    @conn = Faraday.new("https://api.fitbit.com") do |faraday|
        faraday.headers["Authorization"] = "Bearer #{user.token}"
        faraday.adapter Faraday.default_adapter
      end
    @user = user
  end

  def import_thirty_day_data
    thirty_days_ago = "#{Date.today - 30}"
    current_day     = "#{Date.today}"
    get_sleep_info(thirty_days_ago)
    get_activity_info
    get_heart_info
    get_body_info(current_day)
  end

  def get_sleep_info(thirty_days_ago)
    response = @conn.get("/1.2/user/#{@user.uid}/sleep/list.json?afterDate=#{thirty_days_ago}&sort=desc&offset=0&limit=30")
    sleep_info = JSON.parse(response.body, symbolize_names: true)[:sleep]
    Sleep.create_sleep_info(sleep_info, @user)
  end

  def get_activity_info
    response = @conn.get("/1/user/#{@user.uid}/activities/activityCalories/date/today/30d.json")
    activity_info = JSON.parse(response.body)["activities-activityCalories"]
    Activity.create_activity_entries(activity_info, @user)
  end

  def get_heart_info
    response = @conn.get("/1/user/#{@user.uid}/activities/heart/date/today/30d.json")
    heart_info = JSON.parse(response.body)["activities-heart"]
    Heart.create_heart_info(heart_info, @user)
  end

  def get_body_info(current_day)
    response = @conn.get("/1/user/#{@user.uid}/body/log/weight/date/#{current_day}/30d.json")
    body_info = JSON.parse(response.body)["weight"]
    Body.create_body_info(body_info, @user)
  end

end
