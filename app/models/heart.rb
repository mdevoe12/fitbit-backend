class Heart < ApplicationRecord
  belongs_to :user

  def self.create_heart_info(heart_info, user)
    heart_info.each do |raw_info|
      user.hearts.create(date: raw_info["dateTime"],
           resting_heart_rate: raw_info["value"]["restingHeartRate"])
    end
  end
  
end
