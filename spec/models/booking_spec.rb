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

  it "Should require start and end dates" do
    user = create(:user_1)
    room = create(:room_1, user: user)

    booking = build(:booking_1, user: user, room: room, start_date: nil, end_date: nil)

    expect(booking).not_to be_valid
    expect(booking.errors[:start_date]).to include("ne peut pas être vide")
    expect(booking.errors[:end_date]).to include("ne peut pas être vide")

    start_date = DateTime.new(2023, 5, 21)
    end_date   = DateTime.new(2023, 5, 20) # End date is before start date

    booking = build(:booking_1, user: user, room: room, start_date: start_date, end_date: end_date)

    expect(booking).not_to be_valid
    expect(booking.errors[:end_date]).to include("must be greater than start date")
  end
end
