class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :label, null: false, unique: true, :index
      t.string :icon

      t.timestamps
    end
  end
end
