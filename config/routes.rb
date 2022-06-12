Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

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
end
