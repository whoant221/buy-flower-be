Rails.application.routes.draw do

  namespace :api do

    namespace :v1 do
      resources :sessions, only: [] do
        collection do
          post :login
          post :register
        end
      end

      resources :shopping_carts, only: [:index, :create, :destroy]

      resources :orders, only: [:create, :show, :destroy, :index] do
        collection do
          post :valid_voucher
          post :apply_voucher
        end
      end

      resources :categories, only: [:index, :show]

      resources :flowers, only: [:show, :index]
    end

    namespace :admin do
      resources :sessions, only: [] do
        collection do
          post :login
        end
      end

      resources :categories, only: [:create, :index, :show, :update]

      resources :flowers, only: [:create, :update, :index, :show]

      resources :flower_details, only: [:create, :update, :index, :show]

      resources :vouchers, only: [:create, :update, :index, :show]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
