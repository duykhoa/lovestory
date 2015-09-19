Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'love_pages' }

  resources :love_pages, only: [:show, :index] do
    resources :invitations, only: [:create]
    resources :posts, only: %i(new create show edit update destroy)
  end

  resources :assets

  resources :invitations, only: [:show]

  root to: 'homes#index'
end
