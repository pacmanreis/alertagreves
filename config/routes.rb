Rails.application.routes.draw do
  devise_for :users
  root to: 'strikes#index'

  resources :strikes do
    collection do
       get 'search'
    end
  end
  resources :unions, only: :create
end
