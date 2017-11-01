Rails.application.routes.draw do

  get '/auth/fitbit/callback', to: 'sessions#create'

  get '/auth/fitbit', as: :fitbit_login

  namespace :api do
    namespace :v1 do
      get 'keys', to: "keys#index"
      # get '/auth/fitbit/callback', to: 'sessions#create'
      # get '/auth/fitbit', as: :fitbit_login
    end
  end


  root "home#index"

end
