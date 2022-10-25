Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions do
        collection do
          post :login
          post :register
        end
      end
    end

    namespace :admin do
      resources :sessions do
        collection do
          post :login
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
