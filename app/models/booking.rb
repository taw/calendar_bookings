class Booking < ActiveRecord::Base
  belongs_to :room

  def date_range
    (self.start)..(self.end)
  end
end
