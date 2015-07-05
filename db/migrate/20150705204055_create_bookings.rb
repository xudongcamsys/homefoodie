class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :event, index: true
      t.references :applicant, index: true

      t.timestamps null: false
    end
  end
end
