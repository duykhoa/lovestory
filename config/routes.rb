Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "love_pages" }

  resources :love_pages, only: [:show]
  resources :posts, only: %i(new create show edit update destroy)

  resources :invitations, only: [:show, :create]
end
