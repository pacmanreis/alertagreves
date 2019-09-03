Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'strikes#index'
  resources :strikes
  resources :unions, only: :create
end
