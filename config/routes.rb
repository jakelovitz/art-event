Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]
  root to: redirect('/session/new')

  resources :user_events, only: %i[create destroy]

  #events
  get '/events/lookup', to: 'events#lookup', as: 'lookup'
  resources :events, only: %i[index, new, create, show]
  post '/events', to: 'events#query_api_with_location'
end
