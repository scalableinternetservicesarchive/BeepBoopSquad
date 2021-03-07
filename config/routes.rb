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
  get '/seed_users', to: 'users#prd_seed_users', as: 'seed_users'
  get '/seed_stocks', to: 'stocks#prd_seed_stocks', as: 'seed_stocks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end