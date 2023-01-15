class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :label, null: false
      t.string :icon

      t.timestamps
    end
    add_index :topics, :label, unique: true
  end
end
