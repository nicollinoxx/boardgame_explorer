Rails.application.routes.draw do
  resources :boardgames, only: [:index] do
    get :fetch, on: :collection
  end

  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "up" => "rails/health#show", as: :rails_health_check
  root "boardgames#index"
end
