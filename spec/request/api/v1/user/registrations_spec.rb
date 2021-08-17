require 'rails_helper'

RSpec.describe 'Registration /api/v1/users', type: :request do
  before(:each) do
    @api_v1_user_registration = '/api/v1/users'
    @current_user = FactoryBot.create(:user)
    @signup_params = {
      user: {
        email: 'example@example.com',
        password: 'password',
        password_confirmation: 'password',
        gender: 'other'
      }
    }
  end

  describe 'when singup params are correct' do
    it 'returns a successful response' do
      sign_up
      expect(response).to have_http_status(:success)
    end

    it 'creates the user' do
      expect {
        sign_up
      }.to change(User, :count).by(1)
    end
    it 'returns the user' do
      sign_up
      json = JSON.parse(response.body)
      expect(json['data']['email']).to eq('example@example.com')
      expect(json['data']['gender']).to eq('other')
      expect(json['data']['provider']).to eq('email')
    end
  end

  describe 'when password and password_confirmation are not the same' do
    it 'does not create a user' do
      expect {
        post @api_v1_user_registration,
             params: @signup_params.merge({ user: { password_confirmation: '1234' } }),
             as: :json
      }.not_to change { User.count }
    end

    it 'does not return a successful response' do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { password_confirmation: '1234' } }),
           as: :json
      expect(response.status).to eq(422)
    end

    it 'return a message error' do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { password_confirmation: '1234' } }),
           as: :json
      json = JSON.parse(response.body)
      expect(json['errors']['password_confirmation']).to include("doesn't match Password")
    end
  end

  describe 'when user email is already registered' do
    it 'does not create a user' do
      expect {
        post @api_v1_user_registration,
             params: @signup_params.merge({ user: { email: @current_user.email } }),
             as: :json
        # raise response.body
      }.not_to change { User.count }
    end

    it 'does not return a successful response' do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { email: @current_user.email } }),
           as: :json
      expect(response.status).to eq(422)
    end

    it 'return a message error' do
      post @api_v1_user_registration,
           params: @signup_params.merge({ user: { email: @current_user.email } }),
           as: :json
      json = JSON.parse(response.body)
      expect(json['errors']['email']).to include('has already been taken')
    end
  end
end

def sign_up
  post @api_v1_user_registration,
       params: @signup_params,
       as: :json
end
