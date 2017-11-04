class User < ApplicationRecord

  has_many :sleeps
  has_many :activities
  has_many :hearts
  has_many :bodies

  def self.find_or_create_from_auth(auth)
    if User.exists?(:uid => auth['uid'])
      user = User.find_by(provider: auth['provider'], uid: auth['uid'])
    else
      user = User.new
      user.provider      = auth['provider']
      user.uid           = auth['uid']
      user.first_name    = auth['extra']['raw_info']['user']['firstName']
      user.last_name     = auth['extra']['raw_info']['user']['lastName']
      user.gender        = auth['extra']['raw_info']['user']['gender']
      user.age           = auth['extra']['raw_info']['user']['age']
      user.height        = auth['extra']['raw_info']['user']['height']
      user.height        = auth['extra']['raw_info']['user']['height']
      user.height        = auth['extra']['raw_info']['user']['height']
      user.token         = auth['credentials']['token']
      user.refresh_token = auth['credentials']['refresh_token']
      user.save
    end
    user
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end

end
