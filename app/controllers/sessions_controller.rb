class SessionsController < ApplicationController

  def create
    redirect_to root_path
    code = params['code']
    FitbitTokenService.get_token(code)
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    binding.pry
  end

  def make_request
    redirect_to "https://www.fitbit.com/oauth2/authorize?response_type=code&client_id=22CKDN&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffitbit%2Fcallback&scope=activity%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=604800"
  end

end
