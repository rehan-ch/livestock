Rails.application.routes.draw do
  resources :services

  devise_for :users

  resources :products, only: [:index, :show], path: 'ads' do

  end 
  resources :categories, only: [:index, :show]
  resources :contacts, only: [:index]
  resources :abouts, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  namespace :dashboard do
    resources :categories
    resources :paid_ads
    resources :products, path: 'my_ads' do
      collection do
        post :get_address
      end
    end
    get '/', to: 'dashboard#index'
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :categories
    resources :products, path: 'my_ads'
  end
end
