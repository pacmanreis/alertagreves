Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'strikes#index'
    resources :strikes do
      collection do
        get 'search'
      end
    end
    resources :submitted_strikes, only: [:new, :create, :index, :destroy]
    resources :unions, only: :create
    resources :reminders, only: [:index, :create, :destroy]
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
