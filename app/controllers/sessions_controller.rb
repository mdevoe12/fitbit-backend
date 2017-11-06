class SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:create]
  skip_before_action :verify_authenticity_token
  protect_from_forgery :except => [:create]

  def create
    code = params['code']
    FitbitTokenService.get_token(code)
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    @user.generate_auth_token
    redirect_to "https://mdevoe12.github.io/fitbit-front-end-react/?token=#{@user.auth_token}"
  end

end
