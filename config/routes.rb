Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'groups#index'
  # root = デフォルトのローカルホストで飛ぶ場所の指定
  # viewフォルダのgroupフォルダのindex.html.hamlファイル
  resources :users, only: [:edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    # groupに紐づくmeseageなのでネストする
  end
end
