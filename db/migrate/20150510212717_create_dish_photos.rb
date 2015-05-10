class CreateDishPhotos < ActiveRecord::Migration
  def change
    create_table :dish_photos do |t|
      t.references :dish, index: true, foreign_key: true
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
