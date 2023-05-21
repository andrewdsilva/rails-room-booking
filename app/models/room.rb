class Room < ApplicationRecord
  belongs_to :user

  has_many :bookings

  slug :title

  enum room_type: { house: 0, apartment: 1 }

  def self.default_sort
    "created_at desc"
  end
end
