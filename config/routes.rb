Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # get "lesson_order/:id/checkout", to: "lesson_orders#checkout", as: "checkout"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lessons
  
  resources :lesson_orders do
    resources :payments, only: :new
  end
  
  resources :bookings

