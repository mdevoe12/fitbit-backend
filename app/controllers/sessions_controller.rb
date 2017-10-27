class SessionsController < ApplicationController

  def create
    redirect_to root_path
    # binding.pry
    code = params['code']

    require 'net/http'
require 'uri'

uri = URI.parse("https://api.fitbit.com/oauth2/token")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/x-www-form-urlencoded"
request["Authorization"] = "Basic MjJDS0ROOjg2YTU4YzRmNDFmY2UxNTkzMTE2MmY5MmM1MzZkOTJk"
request.set_form_data(
  "clientId" => "22CKDN",
  "grant_type" => "authorization_code",
  "redirect_uri" => "http://localhost:3000/auth/fitbit/callback",
  "code" => "4e73ec45202338a2ade131716be43053988242d0",
)

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end
  end

  def make_request
    redirect_to "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=22CKDN&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffitbit%2Fcallback&scope=activity%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=604800"
  end

end
