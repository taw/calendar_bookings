require "rails_helper"

describe Booking do
  let(:start_date) { Date.parse("2017-02-03") }
  let(:end_date) {  Date.parse("2017-03-04") }

  it "#date_range" do
    booking = Booking.new(start: start_date, end: end_date)
    expect(booking.date_range).to eq(start_date..end_date)
  end
end
