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
class Target < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :radius,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  belongs_to :topic
  belongs_to :user

  validates :radius, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :title, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
