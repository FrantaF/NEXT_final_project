Rails.application.routes.draw do

   root 'users#home'
   post "/" => "users#home"
   get "/" => "users#home" 

   post "/users/dashboard" => "users#dashboard"
   get "/users/dashboard" => "users#dashboard"

   #overriding devise   
   devise_scope :user do
      post "/login" => "users/sessions#create"
      get "/login" => "users/sessions#create"
      post '/sign_in' => 'users/sessions#new'      
      get '/sign_in' => 'users/sessions#new'      
   end

   devise_for :users

   resources :dustbins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
