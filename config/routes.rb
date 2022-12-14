require 'sidekiq/web'

Rails.application.routes.draw do

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'tuan' && password == 'tuan'
  end
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do

    namespace :v1 do
      resources :sessions, only: [] do
        collection do
          post :login
          post :register
          post :reset_password
        end
      end

      resources :users, only: [:index] do
        collection do
          put :change_info
        end
      end

      resources :shopping_carts, only: [:index, :create, :destroy]

      resources :orders, only: [:create, :show, :destroy, :index] do
        member do
          post :mark_as_cancelled
        end
      end

      resources :categories, only: [:index, :show]

      resources :flowers, only: [:show, :index]

      resources :vars do
        collection do
          get :color
        end
      end

      resources :comments, only: [:create, :index]

      resources :vouchers, only: [:index] do
        collection do
          post :valid_price
          get 'exchange', to: 'vouchers#can_exchange'
          post :exchange
        end
      end

      resources :buds, only: [:index]
    end

    namespace :admin do

      resources :sessions, only: [] do
        collection do
          post :login
        end
      end

      resources :categories, only: [:create, :index, :show, :update]

      resources :flowers, only: [:create, :update, :index, :show]

      resources :vouchers, only: [:create, :update, :index, :show] do
        collection do
          delete '/:code', to: 'vouchers#destroy'
        end
      end

      resources :buds, only: [:create, :index, :update]

      resources :users, only: [:index, :create, :update]

      resources :orders, only: [:index] do
        member do
          post :mark_as_processing
          post :mark_as_successful
          post :mark_as_cancelled
        end
      end

      resources :reports do
        collection do
          get :analyze_access_page
          get :analyze_profit
          get :analyze_product
        end
      end

    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
