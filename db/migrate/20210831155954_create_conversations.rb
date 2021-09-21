class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :user1
      t.integer :user2
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
