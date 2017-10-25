class Room < ActiveRecord::Base
  has_many :bookings

  def vacant?(start_date, end_date)
    bookings_conflicting_with_passed_start_date = bookings.where(start: start_date)
    bookings_conflicting_with_passed_end_date = bookings.where(end: end_date)
    if bookings_conflicting_with_passed_start_date.any?
      return false
    elsif bookings_conflicting_with_passed_end_date.any?
      return false
    else
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      while(start_date <= end_date) do
        bookings.each do |possibly_conflicting_booking|
          possibly_conflicting_start_date = possibly_conflicting_booking.start
          possibly_conflicting_end_date = possibly_conflicting_booking.end
          while(possibly_conflicting_start_date <= possibly_conflicting_end_date) do
            if possibly_conflicting_start_date == start_date
              return false
            end
            possibly_conflicting_start_date += 1.day
          end
        end
        start_date += 1.day
      end
    end
    return true
  end
end
