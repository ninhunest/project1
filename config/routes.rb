Rails.application.routes.draw do

  get "/microposts", to: "microposts#index"
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
