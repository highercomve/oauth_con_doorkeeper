Rails.application.routes.draw do

  root "application#index"

  use_doorkeeper
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:show, :index, :create]
      resources :clients, only: [:index]
      get '/me' => "credentials#me"
    end
  end
end
