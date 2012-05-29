Immunotoxibase::Application.routes.draw do
  devise_for :users

  match "admin" => "home#admin"

  scope "/admin" do
    resources :sections, except: [:show, :index]
    resources :measures, except: [:show, :index] do
      collection do
        get :tree
        post :rebuild
      end
    end
  end

  match "toc" => "sections#toc"

  root :to => "home#index"
end
