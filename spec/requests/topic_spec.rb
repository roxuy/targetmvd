require 'rails_helper'

RSpec.describe 'Topics API', type: :request do
  it 'returns all topics' do
      get '/api/v1/topics'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(0)
  end
end
