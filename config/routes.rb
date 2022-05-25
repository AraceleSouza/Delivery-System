Rails.application.routes.draw do
  devise_for :functionaries
  devise_for :admins
  root to: 'home#index'
  resources :shipping_companies, only: [:index, :new, :create, :show, :edit, :update] do
    resources :vehicles, only: [:index, :show, :new, :create]
    resources :price_settings, only: [:index, :new, :create]    
  end
  
end
