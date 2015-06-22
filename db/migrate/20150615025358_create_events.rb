class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :organizer, index: true

      t.timestamps null: false
    end
  end
end
