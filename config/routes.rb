Rails.application.routes.draw do
  root to: 'toppages#index'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :events do
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
end
