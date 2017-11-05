require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  # context "create session test" do
  #   it "redirects to react server" do
  #     params = {"code" => "123"}
  #     auth = {"uid" => "321"}
  #     find_auth = User.find_or_create_from_auth(:find_or_create_from_auth)
  #     User.create(uid: "321")
  #     post :create, params: params
  #     FitbitTokenService.stub(:get_token).and_return(auth)
  #     allow(User).to receive(:find_auth).with(auth).and_return(user)
  #     @user.stub(:generate_auth_token).and_return(true)
  #     response.should redirect_to("http://localhost:8080?token=#{@user.auth_token}")
  #   end
  # end
end
