Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions',
        confirmations: 'api/v1/confirmations'
      }

      get '/topics', to: 'topics#index'
      resources :targets, only: %i[index create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
