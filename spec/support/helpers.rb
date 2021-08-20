require 'rails_helper'
module Request
  module Helpers
    def auth_headers
      @auth_headers ||= user.create_new_auth_token
    end

    def json
      JSON.parse(response.body)
    end

    def login
      post '/api/v1/users/sign_in',
           params: { user: { email: user.email, password: user.password } },
           as: :json
    end
  end
end
