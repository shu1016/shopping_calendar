Rails.application.routes.draw do
  devise_for :users
  root to: 'toppages#index'
  resources :users, only: [:index, :show]
  resources :events do
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
end
