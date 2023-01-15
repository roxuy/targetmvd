# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  icon       :string
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_label  (label) UNIQUE
#
class Topic < ApplicationRecord
  validates :label, presence: true, length: { maximum: 255 }, uniqueness: true
end
