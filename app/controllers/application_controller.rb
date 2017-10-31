class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  before_action :require_login!
  helper_method :person_signed_in?, :current_user

  def user_signed_in?
    current_user.present?
  end

  def require_login!
    return true if authenticate_token
    render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  end

  def current_user
    @_current_user ||= authenticate_token
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end
end
