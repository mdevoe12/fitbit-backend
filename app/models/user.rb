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
      user_info  = auth['extra']['raw_info']['user']
      user_creds = auth['credentials']
      user.provider      = auth['provider']
      user.uid           = auth['uid']
      user.first_name    = user_info['firstName']
      user.last_name     = user_info['lastName']
      user.gender        = user_info['gender']
      user.age           = user_info['age']
      user.height        = user_info['height']
      user.token         = user_creds['token']
      user.refresh_token = user_creds['refresh_token']
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
