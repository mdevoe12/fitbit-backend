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
end
