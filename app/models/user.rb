class User < ApplicationRecord

  has_many :sleeps
  has_many :activities
  has_many :hearts
  has_many :bodies

  def self.find_or_create_from_auth(auth)
    if User.exists?(:uid => auth['uid'])
      return User.find_by(provider: auth['provider'], uid: auth['uid'])
    end
    create_new_user(auth)
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end

  private

  def self.create_new_user(auth)
    user = User.new
    user_info          = auth['extra']['raw_info']['user']
    user_creds         = auth['credentials']
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
    thirty_days_ago = "#{Date.today - 30}"
    current_day     = "#{Date.today}"
    FitbitApiService.get_sleep_info(user, thirty_days_ago)
    FitbitApiService.get_activity_info(user)
    FitbitApiService.get_heart_info(user)
    FitbitApiService.get_body_info(user, current_day)
    binding.pry
    user
  end

end
