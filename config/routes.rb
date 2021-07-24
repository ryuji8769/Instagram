Rails.application.routes.draw do

  get '/' => 'homes#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }

  resources :posts

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show, :create] do
    resources :likes, only: [:create, :destroy]
  end

  root 'posts#index'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
