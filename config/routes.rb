Rails.application.routes.draw do
  get 'pages/home'
  
  root 'pages#home'
  
  devise_for :users
  resources :products, only: [:index, :show]
  resources :orders, only: [:new, :create, :show]

  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
    patch 'update_quantity/:id', to: 'carts#update_quantity', as: :update_quantity
  end

  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
    get 'dashboard', to: 'dashboard#index'
    resources :products do
      member do
        delete 'remove_image/:image_id', to: 'products#remove_image', as: :remove_image
      end
    end
    resources :orders, only: [:index, :edit, :update]
    resources :users
  end
end