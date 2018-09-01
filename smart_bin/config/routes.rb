Rails.application.routes.draw do

   root 'login#login'

   devise_for :users

   resources :dustbins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
