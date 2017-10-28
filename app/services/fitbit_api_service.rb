class FitbitApiService

  def initialize(user)
    @conn = Faraday.new("https://api.fitbit.com/oauth2/token") do |faraday|
        faraday.headers["Authorization"] = "Bearer #{user.token}"
        faraday.adapter Faraday.default_adapter
      end
    @uid = user.uid
  end

end
