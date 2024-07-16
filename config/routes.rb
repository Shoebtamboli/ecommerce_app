Rails.application.routes.draw do
  root 'products#index'
  
  devise_for :users
  resources :products, only: [:index, :show]

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :products
  end
end