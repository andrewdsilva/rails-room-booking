# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::Booking, type: :model do
  context "When checking the booking price" do
    let!(:user) { create(:user_1) }
    let!(:room) { create(:room_1, user: user, day_price: 150) }

    it "Book a room and check price" do
      start_date = DateTime.new(2023, 5, 21)
      end_date   = DateTime.new(2023, 5, 24)

      booking = create(:booking_1, user: user, room: room, start_date: start_date, end_date: end_date)

      expect(booking.compute_price).to eq(450)
    end
  end

  context "When checking booking dates" do
    let!(:user)             { create(:user_1) }
    let!(:room)             { create(:room_1, user: user) }
    let!(:existing_booking) { create(:booking_1, start_date: DateTime.new(2023, 6, 10), end_date: DateTime.new(2023, 6, 11), user_id: user.id, room_id: room.id) }

    it "Should require start and end dates" do
      booking = build(:booking_1, user: user, room: room, start_date: nil, end_date: nil)

      expect(booking).not_to be_valid
      expect(booking.errors[:start_date]).to include("ne peut pas être vide")
      expect(booking.errors[:end_date]).to include("ne peut pas être vide")

      start_date = DateTime.new(2023, 5, 21)
      end_date   = DateTime.new(2023, 5, 20) # End date is before start date

      booking = build(:booking_1, user: user, room: room, start_date: start_date, end_date: end_date)

      expect(booking).not_to be_valid
      expect(booking.errors[:end_date]).to include(I18n.t("activerecord.errors.models.booking.invalid_dates"))
    end

    it "should be valid if there are no conflicting bookings" do
      start_date = DateTime.new(2023, 6, 11)
      end_date   = DateTime.new(2023, 6, 12)

      booking = Booking.new(start_date: start_date, end_date: end_date, user_id: user.id, room_id: room.id)
      expect(booking).to be_valid
    end

    it "should be invalid if there are conflicting bookings" do
      start_date = DateTime.new(2023, 6, 9)
      end_date   = DateTime.new(2023, 6, 11)

      booking = Booking.new(start_date: start_date, end_date: end_date, user_id: user.id, room_id: room.id)
      expect(booking).to be_invalid
      expect(booking.errors[:base]).to include(I18n.t("activerecord.errors.models.booking.unavailable_dates"))
    end
  end
end
