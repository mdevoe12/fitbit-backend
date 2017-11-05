require 'rails_helper'

RSpec.describe Body, type: :model do
  before :each do
    @user = User.create(first_name: "Dead",
                        last_name: "Mau5")
  end

  it {should belong_to(:user) }

  it "has attributes" do
    @user.bodies.create(date: Date.today,
                       body_fat: 12.2,
                       bmi: 100.1,
                       weight: 99.9)

    body = Body.first

    expect(body.date).to eq(Date.today)
    expect(body.body_fat).to eq(12.2)
    expect(body.bmi).to eq(100.1)
    expect(body.weight).to eq(99.9)
  end

  it "created bodies info from csv method" do
    body_info = [{"date" => "#{Date.today}",
                  "fat" => 30,
                  "bmi" => 12.1,
                  "weight" => 9999.99}]

    Body.create_body_info(body_info, @user)

    body = Body.first

    expect(Body.count).to eq(1)
    expect(body.date).to eq(Date.today)
    expect(body.body_fat).to eq(30)
    expect(body.bmi).to eq(12.1)
    expect(body.weight).to eq(9999.99)
  end
end
