require "api_constraints"

Rails.application.routes.draw do
  mount Knock::Engine => "/knock"
  
  get 'sessions/new'

  root 'users#index'
  
  resources :users
  resources :apps
  
  get "apikeys" => "apikeys#show", as: :apikey

  get      'login'       =>   'sessions#new'
  post     'login'       =>   'sessions#create'
  delete   'logout'      =>   'sessions#destroy'

  namespace :api, defaults: { format: :json } do
    scope module: :v1,
                  constraints: ApiConstraints.new(version: 1, default: true) do
      resources :thefts, :only => [:show, :index, :create, :update, :destroy]
      resources :creators, :only => [:show, :index] do
        resources :thefts, only: [:index]
      end
    end
  end

  # api end points
  # namespace :api, defaults: { format: :json } do
    
  #   scope module: :v1,
  #               constraints: ApiConstraints.new(version: 1, default: true) do
  #     resources :thefts
  #   end
  # end
  
  # scope "/api" do
  #   scope "/v1" do
  #     scope "/the"
  #   end
  # end
  
end
