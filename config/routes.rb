Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "pages" }
end
