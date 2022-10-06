Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  devise_for :admins

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'site/home#index', as: :site_home
end
