class FitbitApiService

  attr_reader :conn,
              :user

  def initialize(user)
    @conn = Faraday.new("https://api.fitbit.com") do |faraday|
        faraday.headers["Authorization"] = "Bearer #{user.token}"
        faraday.adapter Faraday.default_adapter
      end
    @user = user
  end

  def import_thirty_day_data
    get_sleep_info
    get_activity_info
    get_heart_info
    get_body_info
  end

  def get_sleep_info
    response = get(sleep_url)
    sleep_info = JSON.parse(response.body, symbolize_names: true)[:sleep]
    Sleep.create_sleep_info(sleep_info, @user)
  end

  def sleep_url
    thirty_days_ago = "#{Date.today - 30}"
    "/1.2/user/#{@user.uid}/sleep/list.json?afterDate=#{thirty_days_ago}&sort=desc&offset=0&limit=30"
  end

  def get_activity_info
    response = get(activity_url)
    activity_info = JSON.parse(response.body)["activities-activityCalories"]
    Activity.create_activity_entries(activity_info, @user)
  end

  def activity_url
    "/1/user/#{@user.uid}/activities/activityCalories/date/today/30d.json"
  end

  def get_heart_info
    response = get(heart_url)
    heart_info = JSON.parse(response.body)["activities-heart"]
    Heart.create_heart_info(heart_info, @user)
  end

  def heart_url
    "/1/user/#{@user.uid}/activities/heart/date/today/30d.json"
  end

  def get_body_info
    response = get(body_url)
    body_info = JSON.parse(response.body)["weight"]
    Body.create_body_info(body_info, @user)
  end

  def body_url
    current_day = "#{Date.today}"
    "/1/user/#{@user.uid}/body/log/weight/date/#{current_day}/30d.json"
  end

  def get(url)
    @conn.get(url)
  end

end
