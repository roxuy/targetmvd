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
class Topic < ApplicationRecord
end
