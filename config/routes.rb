Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }


  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'

  resources :customers, only: [:show, :edit, :update] do
    member do
      get :unsubscribe
      patch :withdraw
    end
  end

  resources :items, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy] do
     member do
      delete :destroy_all
    end
  end
  resources :orders, only: [:new, :show, :create, :index] do
   member do
      post :comfirm
      get :complete
    end
  end
  resources :addresses, only: [:index, :edit, :create, :update,:destroy]

  namespace:admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end
