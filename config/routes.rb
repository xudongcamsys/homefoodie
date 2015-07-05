Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'visitors#index'
  
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  
  resources :users do
    resource :profile, only: [:show]
    resources :followees, only: [:index]
    resources :followers, only: [:index]
    resources :events
    resources :dishes do
      collection do
        get 'tags/:tag', to: 'dishes#index', as: :tag
      end

      resources :dish_photos
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :bookings, only: [:index, :create, :destroy] do 
    post :accept
  end

  get 'dish_search', to: 'search#dish'

  resource :location, only: [:update]

  resources :profiles, only: [:index]

  resource :follows, only: [:create, :destroy]
  post 'like_dish_photo/:dish_photo_id', to: 'dish_photo_likes#create', as: :dish_photo_like
end
