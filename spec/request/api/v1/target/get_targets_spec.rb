require 'rails_helper'

RSpec.describe 'Target /api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let!(:topic) { create(:topic) }

  subject do
    get '/api/v1/targets', headers: auth_headers
  end

  it 'should return empty is there is not targets created' do
    subject
    expect(json['targets']).to be_empty
  end

  describe 'when there is target created' do
    let!(:target) do
      create(:target, user: user, topic_id: topic.id)
    end
    it 'should return list of targets' do
      subject
      expect(json['targets']).to_not be_nil
    end
  end
end
