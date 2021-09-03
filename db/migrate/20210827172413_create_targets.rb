class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.references :topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :latitude, null: false, precision: 10, scale: 6
      t.decimal :longitude, null: false, precision: 10, scale: 6
      t.decimal :radius, null: false, precision: 7, scale: 2

      t.timestamps
    end
    add_index :targets, [:latitude, :longitude]
    add_index :targets, :title, unique: true
  end
end
