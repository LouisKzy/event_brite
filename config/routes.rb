Rails.application.routes.draw do
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    
  end
  
  namespace :admin do
    resources :users
    root 'users#index'
  end
  devise_for :users
  resources :static_pages, only: [:index, :secret]
  resources :attendances
  resources :events
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'events#index'
  get 'static_pages/index'
  get 'static_pages/secret'
  
end
