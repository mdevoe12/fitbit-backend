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
    new(user).get_sleep_info
  end

  def get_sleep_info
    response = @conn.get("/1.2/user/3G2M4H/sleep/list.json?afterDate=2017-10-01&sort=desc&offset=0&limit=30")
    binding.pry
    
  end

end
