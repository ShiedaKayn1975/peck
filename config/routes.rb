Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'signup' , to: 'accounts#create'
      post 'signin' , to: 'sessions#create'
      post 'verify_activation_token', to: 'sessions#verify_activation_token'
      post 'change_password', to: 'sessions#change_password'
      get  'profile', to: 'me#profile'

      jsonapi_resources :users do
        resources :actions, only: [:create, :index]
      end

      jsonapi_resources :products
      jsonapi_resources :users
      jsonapi_resources :categories
    end
  end
end
