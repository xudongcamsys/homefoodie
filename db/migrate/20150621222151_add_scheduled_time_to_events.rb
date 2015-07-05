class AddScheduledTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :scheduled_at, :datetime
    add_column :events, :scheduled_hours, :float
  end
end
