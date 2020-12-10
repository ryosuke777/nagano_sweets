Rails.application.routes.draw do
  resources :genres
  devise_for :admins, controllers: {
  sessions: 'admins/sessions'
  }
  devise_for :customers
  root 'devise/sessions#new'

  namespace :admin do
    get 'homes/top'
    # resources :sessions, only: [:new, :create, :destroy]
    get 'admin/sign_in' => 'sessions#new'
    post 'admin/sign_in' => 'sessions#create'
    delete 'admin/sign_out' => 'sessions#destroy'
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
  namespace :public do
    get '/' => 'homes#top'
    get '/about' => 'homes#about'
    resources :items, only: [:index, :show]
    # resources :registrations, only: [:new, :create]
    get 'end_users/sign_up' => 'registrations#new'
    post 'end_users' => 'registrations#create'
    # resources :sessions, only: [:new, :create, :destroy]
    get 'end_users/sign_in' => 'sessions#new'
    post 'end_users/sign_in' => 'sessions#create'
    delete 'end_users/sign_out' => 'sessions#destroy'

    get 'end_users/unsubscribe' => 'end_users#unsubscribe'
    patch 'end_users/withdraw' => 'end_users#withdraw'
    resources :end_users, only: [:show, :edit, :update]
    # get 'end_users/my_page' => 'end_users#show'
    # get 'end_users/edit' => 'end_users#edit'
    # get 'end_users' => 'end_users#update'

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items1/delete_all' => 'cart_items#delete_all'

    get 'orders/thanks' => 'orders#thanks'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :create, :index, :show]


    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  # devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/' => 'public/homes#top'
  # get '/about' => 'public/homes#about'
end
