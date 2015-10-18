Rails.application.routes.draw do
  get '/users/sign_in', to: redirect('#login-modal')
  devise_for :users, controllers: { omniauth_callbacks: 'love_pages' }

  resources :love_pages, only: [:show, :index, :update] do
    resources :invitations, only: [:create]
    resources :posts, only: %i(new create show edit update destroy)
  end

  resources :assets
  resources :invitations, only: [:show]

  root to: 'homes#index'
end
