Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'toppages#index'
  resources :users, only: [:index, :show]
  resources :events do
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
