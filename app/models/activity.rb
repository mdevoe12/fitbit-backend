class Activity < ApplicationRecord
  belongs_to :user

  def self.create_activity_entries(activity_info, user)
    activity_info.each do |raw_info|
      user.activities.create(date: raw_info["dateTime"],
              active_calories_out: raw_info["value"])
    end
  end

end
