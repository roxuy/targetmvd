require 'rails_helper'

describe 'Logout /api/v1/users/sign_out', type: :request do
  let(:user) { create :user }
  before(:each) do
    login
  end

  describe 'when logout params are correct' do
    subject do
      delete '/api/v1/users/sign_out', headers: auth_headers
    end

    it 'should return success' do
      subject
      expect(response).to be_successful
    end

    it 'should remove access-token' do
      subject
      expect(response.has_header?('access-token')).to eq(false)
      expect(response.has_header?('client')).to eq(false)
      expect(response.has_header?('uid')).to eq(false)
    end

    it 'should delete access-token' do
      subject
      expect(user.reload.tokens.count).to eq(0)
    end
  end

  describe 'when headers params are missing' do
    subject do
      delete '/api/v1/users/sign_out'
    end

    it 'should not return success ' do
      subject
      expect(response).to_not be_successful
    end

    it 'should not remove user token ' do
      subject
      expect(user.reload.tokens.count).to eq(1)
    end
  end
end
