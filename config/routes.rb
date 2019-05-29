Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]


  resources :user_events, only: %i[create destroy]

  #events
  get '/events/lookup', to: 'events#lookup', as: 'lookup'
  post '/events', to: 'events#query_api_with_location'
  get '/events/new', to: 'events#new', as: 'new'
  post '/events', to: 'events#create_from_params'
  resources :events, only: %i[index show]
  match '/events' => redirect('/events/lookup'), via: :get

  get '/', to: 'landing_page#home', as: 'home'
  root to: redirect('/')
end
