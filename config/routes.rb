Rails.application.routes.draw do
  root 'posts#index'

  resources :posts
  resources :users, only: :create
  resource :auth, only: :create
end
