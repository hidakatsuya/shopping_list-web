Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'settings' => 'pages#settings'

  resource :token, only: [:show, :destroy] do
    patch :regenerate
  end
  resolve('Token') { [:token] }

  resources :items, except: [:show] do
    member do
      post 'complete'
      post 'incomplete'
    end
  end

  namespace :api do
    post 'items' => 'items#create'
  end
end
