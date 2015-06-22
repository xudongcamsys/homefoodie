class UserEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant, foreign_key: 'participant_id', class_name: 'User'
end
