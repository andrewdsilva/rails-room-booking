class Room < ApplicationRecord
  include ::HasOwnerConcern

  OPTIONS_AVAIABLE = ["self_check_in", "parking", "kitchen", "washer", "dryer", "dishwasher", "wifi", "tv", "bathroom_essentials", "bedroom_comforts",
    "coffee_maker", "hair_dryer"].freeze

  belongs_to :user

  has_many :bookings

  slug :title

  enum room_type: { house: 0, apartment: 1 }

  validates :title, :description, :num_guests, :num_rooms, :num_beds, :num_baths, :day_price, :location, presence: true

  def self.default_sort
    "created_at desc"
  end

  def options_enabled
    OPTIONS_AVAIABLE.select do |option|
      send(option)
    end
  end
end
