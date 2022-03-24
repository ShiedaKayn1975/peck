Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'signup' , to: 'accounts#create'
      post 'signin' , to: 'sessions#create'
      get  'profile', to: 'me#profile'
    end
  end
end
