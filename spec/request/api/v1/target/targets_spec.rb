require 'rails_helper'

RSpec.describe 'Target /api/v1/targets', type: :request do
  let(:user) { create(:user, confirmed_at: Time.zone.today) }
  let!(:user2) { create(:user, confirmed_at: Time.zone.today) }
  let(:topic) { create(:topic) }
  let!(:target) do
    create :target, user: user2, topic_id: topic.id,
                    latitude: -32.528879, longitude: -55.769835, radius: 400
  end

  before(:each) do
    login
  end

  subject do
    post '/api/v1/targets', params: { target: { title: 'target title',
                                                topic_id: topic.id,
                                                latitude: -32.528879,
                                                longitude: -55.769835,
                                                radius: 400.0 } },
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
    expect(json['target']['title']).to eq('target title')
    expect(json['target']['latitude']).to eq('-32.528879')
    expect(json['target']['longitude']).to eq('-55.769835')
    expect(json['target']['radius']).to eq('400.0')
  end

  it 'should return (1) match and (1) conversation' do
    subject
    expect(json['matched_user'].count).to eq(1)
    expect(json['match_conversation'].count).to eq(1)
  end

  describe 'when does not exists another match' do
    subject do
      post '/api/v1/targets', params: { target: { title: 'target title',
                                                  topic_id: topic.id,
                                                  latitude: 32.528879,
                                                  longitude: 55.769835,
                                                  radius: 400.0 } },
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
      expect(json['target']['title']).to eq('target title')
      expect(json['target']['latitude']).to eq('32.528879')
      expect(json['target']['longitude']).to eq('55.769835')
      expect(json['target']['radius']).to eq('400.0')
    end
  end
end
