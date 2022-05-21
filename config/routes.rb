Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :shipping_companies, only: [:index, :new, :create, :show]
end
