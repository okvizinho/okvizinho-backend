Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }, skip: %i[registrations]
  use_doorkeeper

  post "/graphql", to: "public/graphql#execute"
  post '/user/graphql', to: 'user/graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'site/home#index', as: :site_home

  namespace :admin do
    root "admins#index"
    resources :admins

    resources :dashboard
  end
end
