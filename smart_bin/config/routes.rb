Rails.application.routes.draw do

   root 'users#home'
   post "/" => "users#home"
   get "/" => "users#home" 

   post "/solutions" => "users#solutions"
   get "/sultions" => "users#solutions" 

   post "/contact" => "users#contact"
   get "/contact" => "users#contact" 

   post "/subscriptions/pricing_tables" => "subscriptions#pricing_tables"
   get "/subscriptions/pricing_tables" => "subscriptions#pricing_tables"

   post "/users/dashboard" => "users#dashboard"
   get "/users/dashboard" => "users#dashboard"

   #overriding devise      
   devise_scope :user do
      post "/login" => "users/sessions#create"
      get "/login" => "users/sessions#create"
      post '/sign_in' => 'users/sessions#new'      
      get '/sign_in' => 'users/sessions#new'      
      delete '/sign_out' => 'users/sessions#destroy'            
   end

   devise_for :users, controllers: { registrations: "registrations"}

   resources :dustbins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
