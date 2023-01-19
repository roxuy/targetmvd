require 'rails_helper'

RSpec.describe TargetMatcherService, type: :model do
  describe '#call' do
    let!(:user) { create(:user) }
    let!(:topic) { create(:topic) }
    let(:target) { create(:target, user: user, topic_id: topic.id) }

    context 'when there is not match' do
      it 'does not return matches' do
        TargetMatcherService.new(target).call

        expect(Conversation.all.count).to eq(0)
      end
    end

    context 'there is matches' do
      let!(:user2) { create(:user) }
      let!(:target2) do
        create(:target, latitude: target.latitude, longitude: target.longitude,
                        radius: target.radius, user: user2, topic_id: topic.id)
      end
      it 'creates a conversation' do
        TargetMatcherService.new(target).call

        expect(Conversation.all.count).to eq(1)
      end
    end
  end
end
