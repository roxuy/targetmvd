require 'rails_helper'

RSpec.describe 'Topic /api/v1/topics', type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.today) }
  let!(:topics) { create_list(:topic, 10) }
  before (:each) do
    login
  end
  subject do
    get '/api/v1/topics', headers: auth_headers
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
