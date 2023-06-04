class RoomsController < ApplicationController
  include ::CrudConcern

  before_action :init_booking_form, only: [:show]

  private

  def base_class
    ::Room
  end

  def object_class
    base_class.all.with_attached_images
  end

  def strong_params
    [
      :title, :description, :room_type, :num_guests, :num_rooms, :num_beds, :num_baths, :day_price,
      :self_check_in, :parking, :kitchen, :washer, :dryer, :dishwasher, :wifi, :tv, :bathroom_essentials, :bedroom_comforts, :coffee_maker, :hair_dryer,
      :location, :lat, :long, :location_description, { images: [] }
    ]
  end

  def model_params
    :room
  end

  def init_booking_form
    return unless user_signed_in?

    @booking = @object.bookings.new num_guests: 1, user_id: current_user.id
  end
end
