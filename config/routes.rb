Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "love_pages" }
end
