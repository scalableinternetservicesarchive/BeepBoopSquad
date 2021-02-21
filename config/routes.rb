Rails.application.routes.draw do
  root 'home#index'
  resources :transactions, only: [:create, :show, :index], defaults: {format: :json}
  resources :portfolio_value_histories
  resources :exchanges
  resources :ownerships
  resources :stocks
  resources :users
  resources :deposit
  resources :withdrawal
  resources :trade
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end