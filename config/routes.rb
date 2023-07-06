Rails.application.routes.draw do
  resources :locations, only: [:index, :new, :create, :destroy]
  root "locations#index"
end
