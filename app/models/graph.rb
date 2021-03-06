class Graph

  def self.create_graph_data(user)
    [pull_sleep_data(user), pull_activity_heart_data(user)]
  end

  def self.pull_sleep_data(user)
    data_sleep = []
    29.times do |i|
      date = "#{Date.today - (i + 1)}"
      sleep_day_info = user.sleeps.find_by(date_of_wakeup: date)
      data_sleep << {
       date: date,
       rem:  sleep_day_info.rem_minutes,
       light: sleep_day_info.light_minutes,
       deep: sleep_day_info.deep_minutes,
       wake: sleep_day_info.wake_minutes,
       }
    end
    data_sleep.reverse
  end

  def self.pull_activity_heart_data(user)
    data_activity_heart = []
    29.times do |i|
      date = "#{Date.today - (i + 1)}"
      data_activity_heart << {
       date: date,
       heart_rate: user.hearts.find_by(date: date).resting_heart_rate,
       caloriesOut_in_thousands: user.activities.find_by(date: date).active_calories_out / 10
       }
    end
    data_activity_heart.reverse
  end

end
