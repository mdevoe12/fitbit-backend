class Api::V1::FitbitDataController < ApplicationController

  def index
    data = []
    30.times do |i|
      date = "#{Date.today - i}"
      sleep_day_info = User.first.sleeps.find_by(date_of_wakeup: date)
      data << {
       date: date,
       heart_rate: User.first.hearts.find_by(date: date).resting_heart_rate,
       rem: sleep_day_info.rem_minutes,
       light: sleep_day_info.light_minutes,
       deep: sleep_day_info.deep_minutes,
       wake: sleep_day_info.wake_minutes,
       }
    end
    render json: data
  end

end
