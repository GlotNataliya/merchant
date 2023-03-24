Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :admin do
    resources :products, except: %i[show]
    resources :categories, except: %i[show]
  end

  resources :orders do
    get :confirm, on: :member
  end

  resources :reviews, only: %i[new create update]
  resources :addresses
  resources :order_items do
    member do
      post :plus
      post :minus
    end
  end
  resources :products, only: %i[index show]
  resources :feedbacks, only: %i[new create]
  get '/feedbacks', to: 'feedbacks#new', as: 'feedback'

  root "products#index"
end
