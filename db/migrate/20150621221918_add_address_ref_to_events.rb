class AddAddressRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :event_address, index: true, foreign_key: true
  end
end
