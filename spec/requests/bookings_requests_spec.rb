require 'rails_helper'

RSpec.describe "Bookings requests", type: :request do

  let(:room) {
    Room
      .create(number: 1, size: 1)
      .tap{|room|
        room.bookings.create(start: Date.parse("2017-10-10"), end: Date.parse("2017-10-14"))
      }
  }

  it "valid booking" do
    post "/rooms/#{room.id}/bookings",
      params: {start: Date.parse("2017-11-01"), end: Date.parse("2017-11-10")}
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq({"message"=>"Booking created."})
  end

  it "invalid booking" do
    post "/rooms/#{room.id}/bookings",
      params: {start: Date.parse("2017-10-01"), end: Date.parse("2017-11-10")}
    expect(response.status).to eq(422)
    expect(JSON.parse(response.body)).to eq({"message"=>"Booking conflicts with an existing booking"})
  end
end
