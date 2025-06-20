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
  resources :chats, only: %i[index create show] do
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
  get "home/policy"
  get "home/terms"

  namespace :dashboard do
    resources :categories
    resources :paid_ads
    resources :products, path: 'my_ads' do
      collection do
        post :get_address
        get :filtered_categories
      end
    end
    get '/', to: 'dashboard#index'
  end

  namespace :admin do
    resources :sliders
    get '/', to: 'dashboard#index'
    resources :categories do
      member do
        patch :archive
        patch :unarchive
      end
    end
    resources :services
    resources :blogs
    resources :social_media_links
    resources :products, path: 'my_ads' do
      member do
        patch :approve
        patch :reject
      end
      collection do
        get :filtered_categories
      end
    end
    resources :paid_ads do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :users
    resources :chats, only: [:index, :show]
  end

  resources :paid_ads do
    member do
      patch :approve
      patch :reject
    end
  end
end
