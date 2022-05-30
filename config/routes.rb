Rails.application.routes.draw do
  resources :items, except: [:show] do
    member do
      post 'complete'
      post 'incomplete'
    end
  end
end
