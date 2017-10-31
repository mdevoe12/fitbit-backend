class SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:create]


  skip_before_action :verify_authenticity_token

  protect_from_forgery :except => [:create]

  def create
    redirect_to root_path
    code = params['code']
    FitbitTokenService.get_token(code)
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    @user.generate_auth_token
    binding.pry
    # FitbitApiService.get_sleep_info(@user)
  end

end
