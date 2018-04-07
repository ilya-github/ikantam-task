Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/sessions/create', to: 'sessions#create'
  get '/sessions/new', to: 'sessions#new'
  get '/sessions/destroy', to: 'sessions#destroy'
  resources :tweets

  root to: 'sessions#index'
end
