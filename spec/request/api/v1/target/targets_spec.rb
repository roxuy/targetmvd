require 'rails_helper'

RSpec.describe 'Target /api/v1/targets', type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.today) }
  let!(:user2) { create(:user, confirmed_at: Time.zone.today) }
  let(:topic) { create(:topic) }
  let(:title) { 'title' }
  let(:latitude) { '-32.528879' }
  let(:longitude) { '-55.769835' }
  let(:radius) { '400.0' }
  let!(:target) do
    create(:target, user: user2, topic_id: topic.id,
                    latitude: latitude, longitude: longitude, radius: radius)
  end

  before(:each) do
    login
  end

  subject do
    post '/api/v1/targets', params: { target: { title: title,
                                                topic_id: topic.id,
                                                latitude: latitude,
                                                longitude: longitude,
                                                radius: radius } },
                            headers: auth_headers
  end

  it 'should return a successful response' do
    subject
    expect(response).to be_successful
  end

  it 'should return status created' do
    subject
    expect(response).to have_http_status(:created)
  end

  it 'should creates the target' do
    expect {
      subject
    }.to change(Target, :count).by(1)
  end

  it 'should returns the created target' do
    subject
    expect(json['target']['title']).to eq(title)
    expect(json['target']['latitude']).to eq(latitude)
    expect(json['target']['longitude']).to eq(longitude)
    expect(json['target']['radius']).to eq(radius)
  end

  it 'should return (1) match and (1) conversation' do
    subject
    expect(json['matched_user'].count).to eq(1)
    expect(json['match_conversation'].count).to eq(1)
  end

  describe 'when does not exists another match' do
    let(:latitude2) { '32.528879' }
    subject do
      post '/api/v1/targets', params: { target: { title: title,
                                                  topic_id: topic.id,
                                                  latitude: latitude2,
                                                  longitude: longitude,
                                                  radius: radius } },
                              headers: auth_headers
    end
    it 'should return (0) match and (0) conversation ' do
      subject
      expect(json['matched_user'].count).to eq(0)
      expect(json['match_conversation'].count).to eq(0)
    end

    it 'should return status created' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should creates the target' do
      expect {
        subject
      }.to change(Target, :count).by(1)
    end

    it 'should returns the created target' do
      subject
      expect(json['target']['title']).to eq(title)
      expect(json['target']['latitude']).to eq(latitude2)
      expect(json['target']['longitude']).to eq(longitude)
      expect(json['target']['radius']).to eq(radius)
    end
  end
end
