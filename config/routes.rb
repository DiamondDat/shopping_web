Rails.application.routes.draw do
  root to: 'static_pages#home'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  devise_for :users
  resources  :users, only: [:show, :index]
  resources  :products
  resources  :carts,  only: [:index, :create, :update, :destroy]
  resources  :orders, only: [:index, :create, :update, :destroy] do
    member do
      resources :order_products, only: [:create, :destroy]
      get 'order_details'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
