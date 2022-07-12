# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'settings', to: 'settings#edit'
  put 'settings/update_setting'

  resource :token, only: [:show, :destroy] do
    patch 'regenerate'
  end

  resources :items, except: [:show] do
    member do
      post 'complete'
      post 'incomplete'
    end
  end

  namespace :api do
    post 'items', to: 'items#create'
  end

  namespace :mobile do
    get 'sign_in', to: 'sessions#create'
  end
end
