class Api::V1::FitbitDataController < ApplicationController

  skip_before_action :verify_authenticity_token


  def create
    FitbitApiService.get_sleep_info(current_user)

  end

end
