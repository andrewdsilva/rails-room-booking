class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :room_id, :user_id, presence: true
  validate :end_date_greater_than_start_date

  def end_date_greater_than_start_date
    if end_date && start_date && end_date <= start_date
      errors.add(:end_date, "must be greater than start date")
    end
  end

  def self.default_sort
    "created_at desc"
  end

  def total_price
    room.day_price * (end_date - start_date).to_i
  end
end
