class AddMoreAttrsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :description, :text
    add_column :events, :max_participant_count, :integer
  end
end
