require 'rails_helper'

describe 'Registration /api/v1/users', type: :request do
  before(:each) do
    @api_v1_user_registration = '/api/v1/users'
    @signup_params = {
      'user': {
        'email': Faker::Internet.unique.email,
        'password': 'password',
        'password_confirmation': 'password',
        'gender': 'other'
      }
    }
  end

  describe 'when singup params are correct' do
    subject do
      post @api_v1_user_registration,
           params: @signup_params,
           as: :json
    end

    it 'returns a successful response' do
      subject
      expect(response).to be_successful
    end

    it 'creates the user' do
      expect {
        subject
      }.to change(User, :count).by(1)
    end

    it 'returns the user' do
      subject
      expect(json['data']['gender']).to eq('other')
      expect(json['data']['provider']).to eq('email')
    end
  end

  describe 'when password and password_confirmation are not the same' do
    subject do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { password_confirmation: '1234' } }),
           as: :json
    end

    it 'does not create a user' do
      expect {
        subject
      }.not_to change { User.count }
    end

    it 'does not return a successful response' do
      subject
      expect(response.status).to eq(422)
    end

    it 'return a message error' do
      subject
      expect(json['errors']['password_confirmation']).to include("doesn't match Password")
    end
  end

  describe 'when user email is already registered' do
    let(:existed_user) { create :user }
    subject do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { email: existed_user.email } }),
           as: :json
    end

    it 'does not create a user' do
      subject
      expect {
        subject
      }.to change(User, :count).by(0)
    end

    it 'does not return a successful response' do
      subject
      expect(response.status).to eq(422)
    end

    it 'return a message error' do
      subject
      expect(json['errors']['email']).to include('has already been taken')
    end
  end
end
