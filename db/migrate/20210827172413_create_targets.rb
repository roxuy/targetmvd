class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.references :topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.float :radius, null: false

      t.timestamps
    end
    add_index :targets, [:latitude, :longitude]
    add_index :targets, :title, unique: true
  end
end
