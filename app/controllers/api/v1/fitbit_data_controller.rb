class Api::V1::FitbitDataController < ApplicationController

  skip_before_action :require_login!, only: [:index]


  def index
    data = Graph.create_graph_data(current_user)
    render json: data
  end

end
