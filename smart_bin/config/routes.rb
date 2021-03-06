Rails.application.routes.draw do

  
  root 'static#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'braintree/payment' => "braintree#payment"
  get 'braintree/checkout' => "braintree#checkout"
  post 'braintree/checkout' => "braintree#checkout"

  get "/chart" => "users#chart"
  get "/chart/:id" => "users#chart"

  get "/area" => "users#area"
  get "/area/:id" => "users#area"
 

  post "/employee_profiles" => "users#employee_profiles"
  get "/employee_profiles" => "users#employee_profiles"

  get "/solutions", to: "static#solutions" 
  post "/solutions", to: "static#solutions" 

  get "/contact", to: "static#contact"
  post "/contact", to: "static#contact"

  get "/subscriptions/pricing_tables", to: "subscriptions#pricing_tables"
  post "/subscriptions/pricing_tables", to: "subscriptions#pricing_tables"

  get "/users", to: "users#index"
  get "/users/dashboard", to: "users#dashboard"
  get "/users/analytic", to: "users#analytic"
  get "/users/profile", to: "users#profile"
  
  get "/users/chart", to: "users#chart"

  devise_scope :user do
    post "/login" => "users/sessions#create"
    get "/login" => "users/sessions#create"
    post '/sign_in' => 'users/sessions#new'      
    get '/sign_in' => 'users/sessions#new'
    get '/devise/new' => 'users/sessions#new'  
    delete '/sign_out' => 'users/sessions#destroy'            
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :dustbins
  post "/dustbins/:id/update" => "dustbins#update"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
