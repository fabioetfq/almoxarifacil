Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :materials do
    resources :transactions, except: :destroy
  end
  get "/cart", to: "transactions#cart"
  patch "/sale", to: "transactions#sale"
  resources :transactions, only: :destroy
end
