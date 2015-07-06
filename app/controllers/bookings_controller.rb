class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @event = Event.find params[:event_id]

    @bookings = @event.bookings
  end

  def create
    @event = Event.find params[:event_id]
    @applicant = User.find params[:applicant_id]

    @event.booked_by! @applicant

    redirect_to :back
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to :back
  end

  def accept
    @booking = Booking.find(params[:booking_id])

    @booking.event.accept_booking! @booking

    redirect_to :back
  end
end
