class Room < ApplicationRecord
  include ::HasOwnerConcern

  belongs_to :user

  has_many :bookings

  slug :title

  enum room_type: { house: 0, apartment: 1 }

  validates :title, :description, :num_guests, :num_rooms, :num_beds, :num_baths, :day_price, :location, presence: true

  def self.default_sort
    "created_at desc"
  end
end
