require 'rails_helper'

RSpec.describe Heart, type: :model do
  before :each do
    @user = User.create(first_name: "Dead",
                        last_name: "Mau5")
  end

  it {should belong_to(:user) }

  it "creates heart_info from import file" do
    heart_info = [{"dateTime" => "#{Date.today}",
                   "value" => {"restingHeartRate" => 22}}]

    Heart.create_heart_info(heart_info, @user)

    heart = Heart.first

    expect(Heart.count).to eq(1)
    expect(heart.date).to eq(Date.today)
    expect(heart.resting_heart_rate).to eq(22)
  end
end
