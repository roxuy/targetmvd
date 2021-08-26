class AddUniquetoTopicLabel < ActiveRecord::Migration[6.1]
  def change
    add_index :topics, :label, unique: true
  end
end
