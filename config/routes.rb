Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users do
    member do
      get :followings
      get :followers
      get :investerxes
    end
  end
  resources :investerxes, only: [:create, :destroy, :new]
  resources :relationships, only: [:create, :destroy]
end
