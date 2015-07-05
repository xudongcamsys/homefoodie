class Invite < ActiveRecord::Base
  belongs_to :event
  belongs_to :invitee, foreign_key: 'invitee_id', class_name: 'User'
end
