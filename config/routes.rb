Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "api/v1/auth", skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1 do
      resources :jokes, only: [:index, :create]
      resources :votes, only: [:create]
    end
  end
end
