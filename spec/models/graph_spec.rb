require 'rails_helper'

RSpec.describe Graph do
  before :each do
    @user = User.create(first_name: "Dead",
                        last_name: "Mau5")
    30.times do |i|
      @user.sleeps.create!(date_of_wakeup: Date.today - i,
                          rem_minutes: rand(100),
                          light_minutes: rand(100),
                          deep_minutes: rand(100),
                          wake_minutes: rand(100))
      @user.hearts.create!(date: Date.today - i,
                          resting_heart_rate: rand(100))
      @user.activities.create!(date: Date.today - i,
                              active_calories_out: rand(100))
    end
  end

  it "pulls activity heart info" do
    result = Graph.pull_activity_heart_data(@user)

    expect(result.count).to eq(29)
    expect(result.class).to eq(Array)
  end

  it "pulls sleep info" do
    result = Graph.pull_sleep_data(@user)

    expect(result.count).to eq(29)
    expect(result.class).to eq(Array)
  end

  it "creates two arrays" do
    result = Graph.create_graph_data(@user)

    expect(result.count).to eq(2)
    expect(result[0].count).to eq(29)
    expect(result[0].class).to eq(Array)
    expect(result[1].count).to eq(29)
    expect(result[1].class).to eq(Array)
  end

end
