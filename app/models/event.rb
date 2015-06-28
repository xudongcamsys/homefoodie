class Event < ActiveRecord::Base
  after_save :add_organizer_as_participant

  has_many :participated_event_relationships, class_name: 'UserEvent'
  has_many :participants, class_name: 'User', through: :participated_event_relationships
  belongs_to :organizer, class_name: 'User'
  belongs_to :event_address

  delegate :name, to: :organizer, prefix: :organizer
  delegate :address, to: :event_address
  delegate :coords, to: :event_address

  validates :organizer, presence: true
  validates :name, presence: true
  validates :event_address, presence: true
  validates :scheduled_at, presence: true
  validates :scheduled_hours, numericality: {greater_than_or_equal_to: 0}, allow_nil: true
  validates :capacity, numericality: {greater_than_or_equal_to: 0, only_interger: true}, allow_nil: true

  scope :public_only, -> { where(is_private: false) }
  scope :today, -> { where("scheduled_at >= ? and scheduled_at <= ?", Date.today.beginning_of_day, Date.today.end_of_day) }
  scope :past, -> { where("scheduled_at < ?", Date.today.beginning_of_day) }
  scope :upcoming, -> { where("scheduled_at > ?", Date.today.end_of_day) }

  accepts_nested_attributes_for :event_address, allow_destroy: true,
  reject_if: proc { |attributes| attributes['lat'].blank? && attributes['lng'].blank? }


  def self.find_events_by_attendee_name(name)
    Event.includes(:organizer, :participants)
      .where("(users.name like ?) OR (participants_events.name like ?)", "%#{name}%", "%#{name}%")
      .references(:organizer, :participants).order(created_at: :desc)
  end

  def is_organized_by?(a_user)
    organizer == a_user
  end

  def is_participated_by?(a_user)
    a_user && participants.exists?(a_user.id)
  end

  def formatted_scheduled_time
    scheduled_at.to_formatted_s(:long)
  end

  private

  def add_organizer_as_participant
    UserEvent.create(event: self, participant: organizer)
  end
end
