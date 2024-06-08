Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  mount Ckeditor::Engine => '/ckeditor'
  resources :services

  devise_for :users

  resources :products, only: %i[index show], path: 'ads' do
    member do
      post :start_chat
    end
  end
  resources :chats, only: %i[index create] do
    resources :messages, only: %i[create]
  end
  resources :categories, only: [:index, :show]
  resources :services, only: %i[index show]
  resources :blogs, only: %i[index show]
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

  resources :chat do
    resources :messages
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :categories
    resources :services
    resources :blogs
    resources :products, path: 'my_ads'
  end
end
