class Event < ActiveRecord::Base
  after_save :add_organizer_as_participant

  has_many :participated_event_relationships, class_name: 'UserEvent'
  has_many :participants, class_name: 'User', through: :participated_event_relationships
  has_many :bookings
  has_many :applicants, class_name: 'User', through: :bookings
  has_many :invites
  has_many :invitees, class_name: 'User', through: :invites
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
  validates :capacity, numericality: {greater_than_or_equal_to: 0, only_integer: true}, allow_nil: true

  scope :public_only, -> { where(is_private: false) }
  scope :today, -> { where("scheduled_at >= ? and scheduled_at <= ?", Time.zone.today.beginning_of_day, Time.zone.today.end_of_day) }
  scope :past, -> { where("scheduled_at < ?", Time.zone.today.beginning_of_day) }
  scope :upcoming, -> { where("scheduled_at > ?", Time.zone.today.end_of_day) }

  accepts_nested_attributes_for :event_address, allow_destroy: true,
  reject_if: proc { |attributes| attributes['lat'].blank? && attributes['lng'].blank? }


  def self.find_events_by_attendee_name(name)
    includes(:participants)
      .where("users.name like ?", "%#{name}%")
      .references(:participants).order(created_at: :desc)
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

  def is_bookable_by?(applicant)
    applicant && is_future? && !is_booked_by?(applicant) && !is_participated_by?(applicant)
  end

  def is_unbookable_by?(applicant)
    is_future? && is_booked_by?(applicant)
  end

  def is_booked_by?(applicant)
    applicant && applicants.exists?(applicant.id)
  end

  def booked_by!(applicant)
    Booking.create(event: self, applicant: applicant) if !is_booked_by?(applicant)
  end

  def accept_booking!(booking)
    UserEvent.create(event: self, participant: booking.applicant)
    booking.destroy
  end

  def is_future?
    scheduled_at > Time.zone.now
  end

  private

  def add_organizer_as_participant
    UserEvent.create(event: self, participant: organizer)
  end
end
