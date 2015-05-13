Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "love_pages" }

  resources :love_pages, only: [:show]
end
