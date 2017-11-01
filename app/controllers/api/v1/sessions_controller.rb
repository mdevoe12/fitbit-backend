class Api::V1::SessionsController < ApplicationController

  skip_before_action :require_login!, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token
  protect_from_forgery :except => [:create]


  def destroy
    current_user.invalidate_auth_token
    head :ok
  end

end
