require "api_constraints"

Rails.application.routes.draw do
  mount Knock::Engine => "/knock" # used for API authentification
  
  get 'sessions/new'

  root 'users#index'
  
  resources :users
  resources :apps
  
  get "apikeys" => "apikeys#show", as: :apikey

  get      'login'       =>   'sessions#new'
  post     'login'       =>   'sessions#create'
  delete   'logout'      =>   'sessions#destroy'

  # API END POINTS
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
                  constraints: ApiConstraints.new(version: 1, default: true) do
      resources :thefts, :only => [:show, :index, :create, :update, :destroy] do
        resources :positions, only: [:index, :show]
        resources :tags, only: [:index, :show]
      end
      resources :creators, :only => [:show, :index]
      resources :tags, only: [:index, :show]
      resources :positions, only: [:index, :show]
    end
  end
end
