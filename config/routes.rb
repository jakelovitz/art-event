Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]


  resources :user_events, only: %i[create destroy]

  # events
  get '/events/lookup', to: 'events#lookup', as: 'lookup'
  post '/events/api', to: 'events#query_api_with_location'
  resources :events, only: %i[index show new create edit update destroy]
  match '/events' => redirect('/events/lookup'), via: :get
  
  get '/', to: 'landing_page#home', as: 'home'
  root to: redirect('/')
  # delete '/events/:id/delete', to: 'event#destroy', as: 'delete_event'
end
