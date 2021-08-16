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
require 'rails_helper'

RSpec.describe Topic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
