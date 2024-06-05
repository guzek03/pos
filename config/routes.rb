Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'

  resources :taxes
  resources :stocks
  resources :prices
  resources :items
  resources :payments
  resources :uoms
  resources :receptions do
    member do
      patch "confirm", to: "receptions#confirm"
      patch "reject", to: "receptions#reject"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
