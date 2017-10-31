class Api::V1::SessionsController < ApplicationController

  skip_before_action :require_login!, only: [:create]
  skip_before_action :verify_authenticity_token

  protect_from_forgery :except => [:create]



  def create
    code = params['code']
    FitbitTokenService.get_token(code)
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    binding.pry
    @user.generate_auth_token
    FitbitApiService.get_sleep_info(@user)
  end

  def destroy
    current_user.invalidate_auth_token
    head :ok
  end

end
