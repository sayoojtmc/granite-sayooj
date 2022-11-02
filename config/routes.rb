# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tasks, only: [:index, :create], param: :slug

  root "home#index"
  get "*path", to: "home#index", via: :all

  # Defines the root path route ("/")
  # root "articles#index"
end
