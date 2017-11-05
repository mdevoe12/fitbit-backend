require 'rails_helper'

RSpec.describe Sleep, type: :model do
  before :each do
    @user = User.create(first_name: "Dead",
                        last_name: "Mau5")
  end

  it {should belong_to(:user) }

  it "creates sleep info from import file" do
    sleep_info = [{dateOfSleep: "#{Date.today}",
                   levels: {
                     summary:
                      { deep:
                        { minutes: 10 },
                       light:
                        { minutes: 20 },
                       rem:
                        { minutes: 30 },
                       wake:
                        { minutes: 40 } }
                            }
                  }]

    Sleep.create_sleep_info(sleep_info, @user)

    sleep_entry = Sleep.first

    expect(Sleep.count).to eq(1)
    expect(sleep_entry.date_of_wakeup).to eq(Date.today)
    expect(sleep_entry.deep_minutes).to eq(10)
    expect(sleep_entry.light_minutes).to eq(20)
    expect(sleep_entry.rem_minutes).to eq(30)
    expect(sleep_entry.wake_minutes).to eq(40)
  end
end
