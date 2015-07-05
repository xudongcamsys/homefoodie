class AddIsPrivateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :is_private, :boolean, default: false
  end
end
