require 'rails_helper'

RSpec.describe 'Topic /api/v1/topics', type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.today) }
  subject do
    10.times { create(:topic) }
    login
  end

  it 'should return a successful response' do
    subject
    get '/api/v1/topics', headers: auth_headers
    expect(response).to be_successful
  end

  it 'should returns all topics' do
    subject
    get '/api/v1/topics', headers: auth_headers
    expect(JSON.parse(response.body).size).to eq(10)
  end
end
