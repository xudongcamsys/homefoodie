class RenameEventMaxParticipantCountAsCapacity < ActiveRecord::Migration
  def change
    rename_column :events, :max_participant_count, :capacity
  end
end
