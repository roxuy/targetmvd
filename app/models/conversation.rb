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
class Conversation < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: 'user1'
  belongs_to :user2, class_name: 'User', foreign_key: 'user2'
  belongs_to :topic
  validates :user1, presence: true
  validates :user2, presence: true
  validates :topic_id, presence: true
  validate :users_must_be_different
  def users_must_be_different
    errors.add(:user2, "user1 and user2 can't be the same") if user1 == user2
  end
end
