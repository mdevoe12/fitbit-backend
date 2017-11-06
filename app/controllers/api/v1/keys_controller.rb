class Api::V1::KeysController < ApplicationController

  skip_before_action :require_login!, only: [:index]

  def index
    if authenticate_url(request)
      render json: {
        "secret": ENV['FITBIT_CLIENT_SECRET'],
        "id": ENV['FITBIT_CLIENT_ID']
      }
    else
      render json: { errors: [ { detail: "Access denied" } ] }, status: 401
    end
  end

  private

  def authenticate_url(request)
    return true if request.env["HTTP_URL"] == "http://localhost:8080/"
  end

end
