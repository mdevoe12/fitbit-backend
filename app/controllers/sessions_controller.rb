class SessionsController < ApplicationController

  def create
    redirect_to root_path
    code = params['code']
    FitbitTokenService.get_token(code)
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    FitbitApiService.get_sleep_info(@user)
  end

end
