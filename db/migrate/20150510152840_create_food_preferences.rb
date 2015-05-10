class CreateFoodPreferences < ActiveRecord::Migration
  def change
    create_table :food_preferences do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
