# frozen_string_literal: true

Rails.application.routes.draw do
  constraints(lambda { |req| req.format == :json }) do
    resources :tasks, except: %i[new edit], param: :slug
    resources :users, only: [:index, :create]
    resource :preference, only: %i[show update] do
      patch :mail, on: :collection
    end
    resource :session, only: [:create, :destroy]
    resources :comments, only: :create
  end

  root "home#index"
  get "*path", to: "home#index", via: :all
end
