class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.references :event, index: true
      t.references :participant, index: true

      t.timestamps null: false
    end
  end
end
