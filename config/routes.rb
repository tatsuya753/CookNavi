Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # ゲストログイン
  devise_scope :user do
      post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: "homes#top"
    resources :users
    resources :post_recipes
    resources :categories
  end

  scope module: :public do
    root to: "homes#top"
      resources :users do
        collection do
          # 退会確認画面
          get  '/users/check' => 'users#check'
          # 論理削除用のルーティング
          patch  '/users/withdraw' => 'users#withdraw'
        end
      end
    resources :post_recipes
    resources :recipe_comments
    resources :keeps
  end

end
