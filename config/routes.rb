Rails.application.routes.draw do
  devise_for :users

  resources :items, except: [:show] do
    member do
      post 'complete'
      post 'incomplete'
    end
  end
end
