class Room < ActiveRecord::Base
  has_many :bookings

  def vacant?(date_range)
    bookings.none? do |possibly_conflicting_booking|
      date_range.overlaps?(possibly_conflicting_booking.date_range)
    end
  end
end
