class AddImageToDishPhoto < ActiveRecord::Migration
  def change
    add_column :dish_photos, :image, :string
  end
end
