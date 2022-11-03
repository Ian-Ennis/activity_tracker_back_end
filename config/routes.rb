Rails.application.routes.draw do
  resources :users
  resources :activities 
        
  post "/login", to: "auth#login"

  get '*path',
    to: 'fallback#index',
    constraints: ->(req) { !req.xhr? && req.format.html? }
end
