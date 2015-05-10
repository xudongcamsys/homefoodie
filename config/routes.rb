Rails.application.routes.draw do

  root to: 'visitors#index'
  
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :users do
    resource :profile, only: [:show]
    resources :followees, only: [:index]
    resources :followers, only: [:index]
    resources :dishes do
      collection do
        get 'tags/:tag', to: 'dishes#index', as: :tag
      end

      resources :dish_photos
    end
  end

  resource :location, only: [:update]

  resources :profiles, only: [:index]

  resource :follows, only: [:create, :destroy]
end
