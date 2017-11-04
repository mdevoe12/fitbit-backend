class Sleep < ApplicationRecord
  belongs_to :user

  def self.create_sleep_info(sleep_info, user)
    sleep_info.each do |raw_info|
      sleep_nest = raw_info[:levels][:summary]
      user.sleeps.create(date_of_wakeup: raw_info[:dateOfSleep],
                           deep_minutes: sleep_nest[:deep][:minutes],
                          light_minutes: sleep_nest[:light][:minutes],
                            rem_minutes: sleep_nest[:rem][:minutes],
                           wake_minutes: sleep_nest[:wake][:minutes])
    end
  end
  
end
