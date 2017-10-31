class Api::V1::KeysController < ApplicationController

  skip_before_action :require_login!, only: [:index]

  def index
    render json: {
      "secret": ENV['FITBIT_CLIENT_SECRET'],
      "id": ENV['FITBIT_CLIENT_ID']
    }
  end

end
