Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root to: 'strikes#index'
    resources :strikes do
      collection do
        get 'about_us'
        get 'mobile_filter'
        get 'search'
        get 'calendar'
        post 'approval/:id', to: 'strikes#approval', as: :approval

      end
    end
    resources :submitted_strikes, except: [:show]
    resources :reminders, only: [:index, :create, :destroy]
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
