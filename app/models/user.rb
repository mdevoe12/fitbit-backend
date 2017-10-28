class User < ApplicationRecord

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.first_name = auth['extra']['raw_info']['user']['firstName']
    user.last_name = auth['extra']['raw_info']['user']['lastName']
    user.gender = auth['extra']['raw_info']['user']['gender']
    user.age = auth['extra']['raw_info']['user']['age']
    user.height = auth['extra']['raw_info']['user']['height']
    user.height = auth['extra']['raw_info']['user']['height']
    user.height = auth['extra']['raw_info']['user']['height']
    user.token = auth['credentials']['token']
    user.refresh_token = auth['credentials']['refresh_token']

    user.save
    user
  end

end
