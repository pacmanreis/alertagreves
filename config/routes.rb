Rails.application.routes.draw do
  devise_for :users
  root to: 'strikes#index'
  resources :strikes
  resources :syndicates, only: [:new, :create]
end
