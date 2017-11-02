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
    new(user).get_sleep_info(user)
  end

  def get_sleep_info(user)
    response = @conn.get("/1.2/user/3G2M4H/sleep/list.json?afterDate=2017-10-01&sort=desc&offset=0&limit=30")
    sleep_info = JSON.parse(response.body, symbolize_names: true)[:sleep]
    sleep_info.each do |raw_info|
      user.sleeps.create(date_of_wakeup: raw_info[:dateOfSleep],
                                     deep_minutes: raw_info[:levels][:summary][:deep][:minutes],
                                     light_minutes: raw_info[:levels][:summary][:light][:minutes],
                                      rem_minutes: raw_info[:levels][:summary][:rem][:minutes],
                                      wake_minutes: raw_info[:levels][:summary][:wake][:minutes])
    end
  end

end
