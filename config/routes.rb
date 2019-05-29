Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]


  resources :user_events, only: %i[create destroy]

  #events
  get '/events/lookup', to: 'events#lookup', as: 'lookup'
  resources :events, only: %i[index, new, create, show]
  post '/events', to: 'events#query_api_with_location'
  match '/events' => redirect('/events/lookup'), via: :get

  get '/', to: 'landing_page#home', as: 'home'
  root to: redirect('/')
end
