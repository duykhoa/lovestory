Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'love_pages' }

  resources :love_pages, only: [:show, :index] do
    resources :invitations, only: [:create]
  end

  resources :invitations, only: [:show]

  resources :posts, only: %i(new create show edit update destroy)

  root to: 'homes#index'
end
