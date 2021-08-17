require 'rails_helper'

RSpec.describe 'Authentication /api/v1/users/sign_in', type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:user)
  end

  describe 'when signup params are correct' do
    it 'should return success' do
      login
      expect(response).to have_http_status(:ok)
    end

    it 'should gives you an access-token' do
      login
      expect(response.has_header?('access-token')).to eq(true)
    end
  end

  describe 'when signup params are incorrect' do
    it 'should return unauthorized ' do
      post '/api/v1/users/sign_in',
           params: { user: { email: @current_user.email, password: '1234' } }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
def login
  post '/api/v1/users/sign_in',
       params: { user: { email: @current_user.email, password: @current_user.password } },
       as: :json
end
