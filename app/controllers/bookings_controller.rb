class BookingsController < ApplicationController
  def create
    room = Room.find_by(params[:room_id])
    start_date = Date.parse(params[:start])
    end_date = Date.parse(params[:end])
    if room.vacant?(start_date..end_date)
      booking = Booking.new(booking_params)
      booking.save!
      render json: { message: 'Booking created.' }, status: :ok
    else
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
