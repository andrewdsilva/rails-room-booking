# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::Booking, type: :model do
  it "Book a room and check price" do
    user = create(:user_1)
    room = create(:room_1, user: user, day_price: 150)

    start_date = DateTime.new(2023, 5, 21)
    end_date   = DateTime.new(2023, 5, 24)

    booking = create(:booking_1, user: user, room: room, start_date: start_date, end_date: end_date)

    expect(booking.total_price).to eq(450)
  end
end
