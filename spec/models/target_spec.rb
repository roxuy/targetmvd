# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(10, 6)   not null
#  longitude  :decimal(10, 6)   not null
#  radius     :decimal(7, 2)    not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_latitude_and_longitude  (latitude,longitude)
#  index_targets_on_title                   (title) UNIQUE
#  index_targets_on_topic_id                (topic_id)
#  index_targets_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  let(:user) { create :user }
  let(:topic) { create :topic }
  let(:target) { build :target, user: user, topic: topic }

  it 'is not valid without latitude' do
    target.latitude = nil
    expect(target).to_not be_valid
  end

  it 'is not valid without longitude' do
    target.longitude = nil
    expect(target).to_not be_valid
  end

  it 'is not valid with a negative radius' do
    target.radius = -10
    expect(target).to_not be_valid
  end

  it 'is not valid without radius' do
    target.radius = nil
    expect(target).to_not be_valid
  end

  it 'is not valid without title' do
    target.title = nil
    expect(target).to_not be_valid
  end

  it 'is not valid without topic_id' do
    target.topic_id = nil
    expect(target).to_not be_valid
  end

  it 'is not valid without user_id' do
    target.user = nil
    expect(target).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(target).to be_valid
  end
end
