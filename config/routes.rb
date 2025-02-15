require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#submit_contact'
  get 'privacy-policy', to: 'pages#privacy_policy', as: :privacy_policy
  get 'terms-of-service', to: 'pages#terms_of_service', as: :terms_of_service
  
  devise_for :users
  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :new, :create, :show]
  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
    patch 'update_quantity/:id', to: 'carts#update_quantity', as: :update_quantity
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :products do
      member do
        delete 'remove_image/:image_id', to: 'products#remove_image', as: :remove_image
      end
    end
    resources :orders, only: [:index, :show, :edit, :update]
    resources :users
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end