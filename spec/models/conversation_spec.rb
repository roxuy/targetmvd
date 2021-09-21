# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  user1      :integer
#  user2      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_conversations_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:topic) { create :topic }

  subject do
    described_class.new(user1: user1,
                        user2: user2,
                        topic: topic)
  end

  it 'is not valid without user1' do
    subject.user1 = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without user2' do
    subject.user2 = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without topic_id' do
    subject.topic = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if user1 and user2 are the same value' do
    subject.user2 = user1
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
end
