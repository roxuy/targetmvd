require 'rails_helper'

RSpec.describe 'Topic /api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:topics) { create_list(:topic, 10) }

  subject do
    get '/api/v1/topics',
        headers: auth_headers
  end

  it 'should return a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'should returns all topics' do
    subject
    expect(JSON.parse(response.body).size).to eq(10)
  end
end
