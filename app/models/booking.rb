class Booking < ApplicationRecord
  include ::HasOwnerConcern

  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :room_id, :user_id, presence: true
  validate :end_date_greater_than_start_date
  validate :dates_are_available

  before_save :set_price_ht, if: :start_or_end_changed?

  def end_date_greater_than_start_date
    errors.add(:end_date, I18n.t("activerecord.errors.models.booking.invalid_dates")) if end_date && start_date && end_date <= start_date
  end

  def dates_are_available
    conflicting_bookings = room.bookings.where.not(id: id).where("(? < end_date) AND (? > start_date)", start_date, end_date)

    errors.add(:base, I18n.t("activerecord.errors.models.booking.unavailable_dates")) if conflicting_bookings.exists?
  end

  def self.default_sort
    "created_at desc"
  end

  def compute_price
    room.day_price * (end_date - start_date).to_i
  end

  def start_formated
    I18n.l(start_date, format: :long)
  end

  def end_formated
    I18n.l(end_date, format: :long)
  end

  def formated_dates
    "#{start_formated} - #{end_formated}"
  end

  def start_or_end_changed?
    start_date_changed? || end_date_changed?
  end

  def set_price_ht
    self.total_ht = compute_price
  end

  def total_ttc
    total_ht * 1.2
  end

  def canceled?
    canceled_at.present?
  end

  def cancel!
    update_attribute :canceled_at, Time.now
  end
end
