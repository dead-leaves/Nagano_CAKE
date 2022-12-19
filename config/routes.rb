Rails.application.routes.draw do

    namespace :admin do

     get '/' => 'homes#top'

     resources :items, only: [:index, :new, :create, :show, :edit, :update]

     resources :genres, only: [:index, :create, :edit, :update]

     resources :customers, only: [:index, :show, :edit, :update]

     resources :orders, only: [:show, :update]

     resources :order_details, only: [:update]

    end



    scope module: :public do

     get root to: 'homes#top'
     get 'about' => 'homes#about', as: 'about'

     resources :addresses, only: [:index, :edit, :create, :update, :destroy]


     post 'orders/confirm' => 'orders#confirm'
     get 'orders/thanks' => 'orders#thanks'

     resources :orders, only: [:new, :create, :index, :show]


     delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
     resources :cart_items, only: [:index, :update, :destroy, :create]


     resource :customers, only: [:show, :update]
     get 'customers/infomation/edit' => 'customers#edit'
     get 'customers/unsubscribe' => 'customers#unsubscribe'
     patch 'customers/withdrawal' => 'customers#withdrawal'

     resources :items, only: [:index, :show]

    end

      devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
     }

      devise_for :customers, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
      }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
