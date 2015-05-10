class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.references :food_preference, index: true, foreign_key: true
      t.references :food_type, index: true, foreign_key: true
      t.references :cuisine, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true, null: false

      t.string :name, null: false
      t.string :ingredients

      t.timestamps null: false
    end
  end
end
