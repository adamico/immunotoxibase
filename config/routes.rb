Immunotoxibase::Application.routes.draw do
  devise_for :users

  resources :molecules

  root :to => "home#index"
end
