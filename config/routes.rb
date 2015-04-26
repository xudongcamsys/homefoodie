Rails.application.routes.draw do

  root to: 'visitors#index'
  
  devise_for :users
  
  resources :users do
    resource :profile, only: [:show]
  end

  resources :profiles, only: [:index]

  resource :follows, only: [:create, :destroy]
end
