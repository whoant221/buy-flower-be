Rails.application.routes.draw do
  namespace :api do
    namespace :admin do
      get 'flower_details/create'
      get 'flower_details/update'
      get 'flower_details/index'
      get 'flower_details/show'
    end
  end
  namespace :api do
    namespace :admin do
      get 'flower_detail/create'
      get 'flower_detail/index'
      get 'flower_detail/show'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [] do
        collection do
          post :login
          post :register
        end
      end

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
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
