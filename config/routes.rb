Rails.application.routes.draw do
  root "movies#index"

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :create] do
        collection do
          get "/search", to: "search#index", as: :search
        end
      end
    end
  end
end
