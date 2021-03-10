Rails.application.routes.draw do
  root 'home#index'
  resources :transactions
  resources :portfolio_value_histories
  resources :exchanges
  resources :ownerships
  resources :stocks
  resources :users
  resources :trade
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/seed_users/:seed_id', to: 'users#prd_seed_users'
  get '/seed_stocks/:seed_id', to: 'stocks#prd_seed_stocks'
  get '/destroy_users', to: 'users#destroy_users'
  get '/destroy_stocks', to: 'stocks#destroy_stocks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end