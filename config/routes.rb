Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :customers, only: [:index, :show]
    end
  end
end
