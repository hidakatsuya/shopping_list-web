Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :items, except: [:show] do
    member do
      post 'complete'
      post 'incomplete'
    end

    collection do
      get 'recently_used'
    end
  end
end
