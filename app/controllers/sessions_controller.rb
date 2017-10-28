class SessionsController < ApplicationController

  def create
    redirect_to root_path
    code = params['code']

    conn = Faraday.new("https://api.fitbit.com/oauth2/token") do |faraday|
      faraday.headers["Authorization"] = "Basic MjJDS0ROOjg2YTU4YzRmNDFmY2UxNTkzMTE2MmY5MmM1MzZkOTJk"
      faraday.params["clientID"] = "#{ENV["FITBIT_CLIENT_ID"]}"
      faraday.params["grant_type"] = "authorization_code"
      faraday.params["code"] = code
      faraday.params["redirect_uri"] = "http://localhost:3000/auth/fitbit/callback"
      faraday.adapter Faraday.default_adapter
    end

    conn.post

    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    binding.pry
  end

  def make_request
    redirect_to "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=22CKDN&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffitbit%2Fcallback&scope=activity%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=604800"
  end

end
