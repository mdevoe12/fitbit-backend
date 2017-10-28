class FitbitTokenService

  def self.connect(code)
    @conn = Faraday.new("https://api.fitbit.com/oauth2/token") do |faraday|
        faraday.headers["Authorization"] = "Basic MjJDS0ROOjg2YTU4YzRmNDFmY2UxNTkzMTE2MmY5MmM1MzZkOTJk"
        faraday.params["clientID"] = "#{ENV["FITBIT_CLIENT_ID"]}"
        faraday.params["grant_type"] = "authorization_code"
        faraday.params["code"] = code
        faraday.params["redirect_uri"] = "http://localhost:3000/auth/fitbit/callback"
        faraday.adapter Faraday.default_adapter
      end
  end

  def self.get_token(code)
    FitbitTokenService.connect(code)
    @conn.post
  end

end
