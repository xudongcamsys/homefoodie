class CreateEventAddresses < ActiveRecord::Migration
  def change
    create_table :event_addresses do |t|
      t.float :lat
      t.float :lng
      t.string :address

      t.timestamps null: false
    end
  end
end
