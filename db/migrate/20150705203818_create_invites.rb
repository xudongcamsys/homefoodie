class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :event, index: true
      t.references :invitee, index: true

      t.timestamps null: false
    end
  end
end
