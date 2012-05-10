Immunotoxibase::Application.routes.draw do
  devise_for :users

  scope "/admin" do
    resources :chapters, :families, :molecules, except: [:show, :index]
  end

  match "toc" => "toc#index"

  root :to => "home#index"
end
