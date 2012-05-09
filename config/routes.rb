Immunotoxibase::Application.routes.draw do
  devise_for :users

  resources :molecules
  resources :chapters
  resources :families
  match "toc" => "toc#index"

  root :to => "home#index"
end
