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
    user_info  = auth['extra']['raw_info']['user']
    user_creds = auth['credentials']
    user = User.create!(
           provider:  auth['provider'],
                uid:  auth['uid'],
         first_name:  user_info['firstName'],
          last_name:  user_info['lastName'],
             gender:  user_info['gender'],
                age:  user_info['age'],
             height:  user_info['height'],
              token:  user_creds['token'],
      refresh_token:  user_creds['refresh_token']
    )
    import_data(user)
    user
  end

  def self.import_data(user)
    fitbit_api_connection = FitbitApiService.new(user)
    fitbit_api_connection.import_thirty_day_data
  end

end
