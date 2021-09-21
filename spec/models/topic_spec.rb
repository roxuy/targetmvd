# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  icon       :string
#  label      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_label  (label) UNIQUE
#
require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { build :topic }

  it 'is valid with required attributes' do
    expect(topic).to be_valid
  end

  it 'is not valid without label' do
    topic.label = nil
    expect(topic).to_not be_valid
  end
end
