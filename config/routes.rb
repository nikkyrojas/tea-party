Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :sessions, only: [:create, :index, :destroy]
      resources :customers, only: [:show, :index, :create]
      resources :teas, only: [:create, :index, :destroy]
      resources :subscriptions, only: [:create, :index, :destroy, :update, :edit]
    end
  end
end
