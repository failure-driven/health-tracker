Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  root to: "home#index"
end
