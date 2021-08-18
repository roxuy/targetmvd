require 'rails_helper'

describe 'Authentication /api/v1/users/sign_in', type: :request do
  let(:user) { create :user }

  describe 'when signup params are correct' do
    subject do
      post '/api/v1/users/sign_in',
           params: { user: { email: user.email, password: user.password } },
           as: :json
    end

    it 'should return success' do
      subject
      expect(response).to be_successful
    end

    it 'should gives you an access-token' do
      subject
      expect(response.has_header?('access-token')).to eq(true)
    end
  end

  describe 'when signup params are incorrect' do
    it 'should return unauthorized ' do
      post '/api/v1/users/sign_in',
           params: { user: { email: user.email, password: '1234' } }, as: :json
      expect(response).to be_unauthorized
    end
  end
end
