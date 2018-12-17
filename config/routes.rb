Rails.application.routes.draw do
  resources :patients do
    resources :appointments
  end
end
