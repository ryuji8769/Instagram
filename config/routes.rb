Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
