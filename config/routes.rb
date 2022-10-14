Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  devise_for :admins, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }, skip: %i[registrations]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'site/home#index', as: :site_home

  namespace :admin do
    root "admins#index"
    resources :admins

    resources :dashboard
  end
end
