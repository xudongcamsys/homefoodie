class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :is_geocodable, default: false
      t.boolean :is_visible, default: false
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
