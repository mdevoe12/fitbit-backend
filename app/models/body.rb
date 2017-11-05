class Body < ApplicationRecord
  belongs_to :user

  def self.create_body_info(body_info, user)
    body_info.each do |raw_info|
      user.bodies.create(date: raw_info["date"],
                     body_fat: raw_info["fat"],
                          bmi: raw_info["bmi"],
                       weight: raw_info["weight"])
    end
  end

end
