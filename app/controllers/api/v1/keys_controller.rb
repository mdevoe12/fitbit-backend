class Api::V1::KeysController < ApplicationController

  def index
    render json: {
      "secret": ENV['FITBIT_CLIENT_SECRET'],
      "id": ENV['FITBIT_CLIENT_ID']
    }
  end

end
