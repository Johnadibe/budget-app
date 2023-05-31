Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "categories#index"
  get '/welcome', to: 'categories#splash', as: 'welcome'

  resources :categories, only: %i[new create index] do
    resources :transactions, only: %i[index]
  end
  resources :users, only: %i[index]
  # Defines the root path route ("/")
end
