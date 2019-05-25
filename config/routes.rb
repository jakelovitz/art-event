Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]
  root to: redirect('/session/new')


  #events
  resources :events, only: %i[index]
  get '/events/lookup', to: 'events#lookup', as: 'lookup'
  post '/events', to: 'events#query_api_with_location'
end
