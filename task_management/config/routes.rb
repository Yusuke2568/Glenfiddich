Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  # ログイン/ログアウト
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  get 'registration', to: 'registrations#new'
  post 'registration', to: 'registrations#create'

  resources :users, only: %i(new create)
  resources :workspace_members, only: %i(index show)

  resources :projects, only: %i(index)

  root to: "dashboards#index"

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
