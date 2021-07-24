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

  # フォローしたり、フォローを外すためのアクションを定義する準備
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

  # 「フォロー一覧」と「フォロワー一覧」のページ
  resources :users, only: [:show] do
    get :following, :follower, on: :member
  end

  # コメント
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end
end
