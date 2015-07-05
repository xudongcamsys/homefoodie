class Booking < ActiveRecord::Base
  belongs_to :event
  belongs_to :applicant, foreign_key: 'applicant_id', class_name: 'User'

  def formatted_booking_time
    created_at.to_formatted_s(:long)
  end
end
