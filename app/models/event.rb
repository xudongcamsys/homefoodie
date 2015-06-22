class Event < ActiveRecord::Base
  has_many :user_events
  has_many :participants, class_name: 'User', through: :user_events
  belongs_to :organizer, class_name: 'User'
  belongs_to :event_address

  accepts_nested_attributes_for :event_address, allow_destroy: true,
  reject_if: proc { |attributes| attributes['lat'].blank? && attributes['lng'].blank? }


  def self.find_events_by_attendee_name(name)
    Event.includes(:organizer, :participants)
      .where("(users.name like ?) OR (participants_events.name like ?)", "%#{name}%", "%#{name}%")
      .references(:organizer, :participants).order(created_at: :desc)
  end
end
