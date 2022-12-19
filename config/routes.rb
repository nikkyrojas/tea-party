Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :sessions, only: [:create, :index, :destroy]
      resources :customers, only: [:index, :create]
      resources :teas, only: [:index]
      resources :subscriptions, only: [:index]
    end
  end
end
