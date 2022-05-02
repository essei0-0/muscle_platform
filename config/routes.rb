Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/prepare',   to: 'static_pages#prepare'
  get '/signup',  to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/health_records',  to: 'health_records#new'
  get '/meal_records', to: 'meal_records#new'
  resources :users, only: [:show, :edit, :update] do
    member do
      get :following, :followers, :students, :header_records, :meal_records
    end
  end
  resources :microposts, only: [:show, :create, :destroy] do
    resources :reposts, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :deep_relationships, only: [:create, :destroy]
  resources :health_records, only: [:create, :destroy]
  resources :meal_records, only: [:edit, :create, :destroy]
  resources :replies, only: [:create, :destroy]
end
