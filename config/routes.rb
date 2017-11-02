Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :listings do
     resources :reservations
   end
  resources :tags


  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root 'users#index'

  resources :users, except: [:index, :create]

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  post "/listings/:id/verify" => "listings#verify", as: "verify"

  get '/search', to: "listings#search", as: "search"
  get 'reservations/:id/payment' => "reservations#payment"
  post 'reservations/:id/checkout' => "reservations#checkout", as: "reservations_checkout"

end
