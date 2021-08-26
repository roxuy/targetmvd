require 'rails_helper'

describe 'Confirmation /api/v1/users/confirmation', type: :request do
  let(:user) { create(:user, confirmed_at: nil) }

  describe 'when signup params are correct' do
    subject do
      get '/api/v1/users/confirmation',
          params: { confirmation_token: user.confirmation_token, redirect_url: 'confirmed' }
    end

    it 'should return success status' do
      subject
      expect(response).to be_successful
    end

    it 'should confirm the email' do
      subject
      expect(user.reload.confirmed?).to be true
    end
  end

  describe 'when signup params are incorrect' do
    subject do
      get '/api/v1/users/confirmation',
          params: { confirmation_token: 'wrong', redirect_url: 'confirmed' }
    end

    it 'should return unprocessable status' do
      subject
      expect(response).to be_unprocessable
    end

    it 'should not confirm the email' do
      subject
      expect(user.reload.confirmed?).to be false
    end
  end
end
