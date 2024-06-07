Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'

  resources :taxes
  resources :stocks
  resources :prices do
    member do
      get "get_price", to: "prices#get_price"
    end
  end
  resources :items do
    collection do
      get "get_items_active", to: "items#get_items_active"
    end
  end
  resources :payments
  resources :uoms
  resources :receptions do
    member do
      patch "confirm", to: "receptions#confirm"
      patch "reject", to: "receptions#reject"
    end
  end
  resources :order_headers do
    member do
      patch "on_process", to: "order_headers#on_process"
      get "on_check", to: "order_headers#on_check"
      post "submit_on_check", to: "order_headers#submit_on_check"
      get "on_confirm", to: "order_headers#on_confirm"
      patch "submit_confirm", to: "order_headers#submit_confirm"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
