class Api::V1::FitbitDataController < ApplicationController

  skip_before_action :require_login!, only: [:index]


  def index
    data_sleepHeartRate = []
    30.times do |i|
      date = "#{Date.today - i}"
      sleep_day_info = User.first.sleeps.find_by(date_of_wakeup: date)
      data_sleepHeartRate << {
       date: date,
       heart_rate: User.first.hearts.find_by(date: date).resting_heart_rate,
       rem: sleep_day_info.rem_minutes,
       light: sleep_day_info.light_minutes,
       deep: sleep_day_info.deep_minutes,
       wake: sleep_day_info.wake_minutes,
       }
    end
    data_weightActivity = []
    30.times do |i|
      date = "#{Date.today - i}"
      data_weightActivity << {
       date: date,
       rem: User.first.sleeps.find_by(date_of_wakeup: date).rem_minutes,
       caloriesOut: User.first.activities.find_by(date: date).active_calories_out
       }
    end
    data = [data_sleepHeartRate.reverse, data_sleepHeartRate.reverse]
    render json: data
  end

  def find_weight(date)
    if (User.first.bodies.find_by!(date: date)).success?
      return User.first.bodies.find_by(date: date).weight
    end
    return 0
  end

  def show
    data_weightActivity = []
    30.times do |i|
      date = "#{Date.today - i}"
      data << {
       date: date,
       weight: User.first.bodies.find_by(date: date).weight,
       caloriesOut: User.first.activities.find_by(date: date).active_calories_out
       }
    end
    render json: data.reverse
  end

end
