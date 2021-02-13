Rails.application.routes.draw do
  resources :transactions
  resources :portfolio_value_histories
  resources :exchanges
  resources :ownerships
  resources :stocks
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
