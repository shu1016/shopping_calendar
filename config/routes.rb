Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :users, only: [:index, :show]
  resources :events do
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
end
