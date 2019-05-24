Rails.application.routes.draw do
  resources :users, except: %i[index]
  resource :session, only: %i[new create destroy]
  root to: redirect('/session/new')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
