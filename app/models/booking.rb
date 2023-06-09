class Booking < ApplicationRecord
  include ::HasOwnerConcern

  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, :room_id, :user_id, presence: true
  validate :end_date_greater_than_start_date

  before_save :set_price_ht, if: :start_or_end_changed?

  def end_date_greater_than_start_date
    errors.add(:end_date, "must be greater than start date") if end_date && start_date && end_date <= start_date
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
