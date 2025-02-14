Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'api/v1/auth/login', to: 'authentication#login'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy] do
        resources :bookings, only: %i[index show create]
      end
      resources :vehicles, only: %i[index show create destroy] do
        resources :bookings, only: %i[index show create]
        resources :galleries, only: %i[index create]
      end
    end
  end
end
