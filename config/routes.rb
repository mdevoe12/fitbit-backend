Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/fitbit/callback', to: 'sessions#create'
  # post '/auth/fitbit', to: 'sessions#make_request'

  get '/auth/fitbit', as: :fitbit_login


  root "home#index"

end
