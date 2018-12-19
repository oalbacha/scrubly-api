Rails.application.routes.draw do
  resources :patients do
    resources :appointments
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
