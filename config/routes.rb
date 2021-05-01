Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :daily_stats

    root to: "users#index"
  end
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
  post "/graphql", to: "graphql#execute"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  resource :app, only: [:show]
  get "/app/*all" => "apps#show"

  authenticated :user do
    get "/", to: redirect("/app")
  end
  root to: "home#index"
end
