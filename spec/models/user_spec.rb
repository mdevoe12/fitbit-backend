require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:hearts) }
  it {should have_many(:bodies) }
  it {should have_many(:activities) }
  it {should have_many(:sleeps) }


  it "should find existing user from auth" do
    user = User.create(uid: "test123")

    auth = {"uid" => "test123" }

    result = User.find_or_create_from_auth(auth)

    expect(result).to eq(user)
  end

  it "should create new user if not found" do
    auth = {
      "provider" => "fitbit",
      "uid" => "321test",
      "credentials" => {
        "token" => "123",
        "refresh_token" => "432"
      },
      "extra" => {
        "raw_info" => {
          "user" => {
            "firstName" => "Jack",
            "lastName" => "Johnson",
            "gender" => "male",
            "age" => 99,
            "height" => 72
          }
        }
      }
    }

    User.create_new_user(auth)

    user = User.first

    expect(user.first_name).to eq("Jack")
    expect(user.last_name).to eq("Johnson")
    expect(user.provider).to eq("fitbit")
    expect(user.uid).to eq("321test")
    expect(user.gender).to eq("male")
    expect(user.age).to eq(99)
    expect(user.height).to eq(72)
    expect(user.token).to eq("123")
    expect(user.refresh_token).to eq("432")
  end

  it "generates random token" do
    user = User.create(first_name: "test")

    expect(user.auth_token).to eq(nil)

    user.generate_auth_token

    expect(user.auth_token).to be_instance_of(String)
    expect(user.auth_token.length).to eq(32)
  end

  it "invalidates auth token" do
    user = User.create(auth_token: "987654321")

    expect(user.auth_token).to eq("987654321")

    user.invalidate_auth_token

    expect(user.auth_token).to eq(nil)
    
  end

end
