Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :products do
    resources :comments, only: %i[create update destroy]
  end

  resources :line_items, only: %i[create destroy]
  resource :cart, only: %i[create show destroy]

  post '/line_items/:product_id', to: 'line_items#create'
  post '/checkout/new', to: 'checkout#create'
  get '/checkout/new', to: 'checkout#new', as: 'new_checkout'
  get '/contact', to: 'welcome#contact', as: 'contact'
  get '/about', to: 'welcome#about', as: 'about'
  get '/checkout/coupon', to: 'checkout#coupon', as: 'coupon'
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
