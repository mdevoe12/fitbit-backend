require 'rails_helper'

RSpec.describe Activity, type: :model do
  before :each do
    @user = User.create(first_name: "Shingo",
                        last_name: "Nakamura")
  end

  it { should belong_to(:user) }

  it "has attributes" do
    @user.activities.create(date: Date.today,
             active_calories_out: 27)

    expect(Activity.first).to eq(@user.activities.first)
    expect(Activity.first.date).to eq(Date.today)
    expect(Activity.first.active_calories_out).to eq(27)
  end

  it "created activities from csv method" do
    activity_info = [{"dateTime" => "#{Date.today}", "value" => 30}]

    Activity.create_activity_entries(activity_info, @user)

    expect(Activity.count).to eq(1)
    expect(Activity.first.date).to eq(Date.today)
    expect(Activity.first.active_calories_out).to eq(30)
  end
end
