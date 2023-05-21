class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def self.default_sort
    "created_at desc"
  end

  def total_price
    room.day_price * (end_date - start_date).to_i
  end
end
