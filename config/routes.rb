Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      get '/topics', to: 'topic#index'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
