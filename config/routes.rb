Rails.application.routes.draw do
  root 'home#index'
  
  resources :taxes
  resources :stocks
  resources :prices
  resources :items
  resources :payments
  resources :uoms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
