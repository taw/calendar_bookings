class BookingsController < ApplicationController
  def create
    room = Room.find_by(params[:room_id])
    if room_vacant(room)
      booking = Booking.new(booking_params)
      booking.save!
      render json: { message: 'Booking created.' }, status: :ok
    else
      render json: { message: 'Booking conflicts with an existing booking' }, status: :unprocessable_entity
    end
  end

  private

  def room_vacant(room) # TEMP
    room.vacant?(params[:start], params[:end])
  end

  def booking_params
    params.permit(:start, :end, :room_id)
  end
end
