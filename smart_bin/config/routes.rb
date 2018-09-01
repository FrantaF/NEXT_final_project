Rails.application.routes.draw do

   root 'users#home'

   post "/" => "users#home"
   get "/" => "users#home"

   post "/login" => "login#login"
   get "/login" => "login#login"

   devise_for :users

   resources :dustbins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
