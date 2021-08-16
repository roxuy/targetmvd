class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :label
      t.string :icon

      t.timestamps
    end
  end
end
