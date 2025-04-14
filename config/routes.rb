Rails.application.routes.draw do
  resources :order_items
  resources :orders
  resources :addresses
  resources :cart_items
  resources :carts
  get '/my_cart', to: 'carts#show_current', as: 'my_cart'
  resources :products
  resources :categories
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  # Static pages with friendly URLs
  get '/about', to: 'pages#show', page: 'about'
  get '/contact', to: 'pages#show', page: 'contact'
  get '/privacy', to: 'pages#show', page: 'privacy'
  get '/terms', to: 'pages#show', page: 'terms'
  get '/faq', to: 'pages#show', page: 'faq'
  get '/shipping', to: 'pages#show', page: 'shipping'
  get '/returns', to: 'pages#show', page: 'returns'

  # Catch-all route for any additional static pages
  # This should be placed near the end of your routes file
  # get '/pages/:page', to: 'pages#show'
  root "pages#index"
end
