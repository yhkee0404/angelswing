Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      api_guard_routes for: :users, only: [:registration, :authentication]
      api_guard_scope :users do
        post 'users/signup' => 'api_guard/registration#create'
        post 'auth/signin' => 'api_guard/authentication#create'
      end

      resources :contents
      get 'content' => 'contents#index'
    end
  end
end
