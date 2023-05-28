class RoomsController < ApplicationController
  include ::CrudConcern

  private

  def base_class
    ::Room
  end

  def object_class
    base_class.all
  end

  def strong_params
    [
      :title, :description, :room_type, :num_guests, :num_rooms, :num_beds, :num_baths, :day_price,
      :self_check_in, :parking, :kitchen, :washer, :dryer, :dishwasher, :wifi, :tv, :bathroom_essentials, :bedroom_comforts, :coffee_maker, :hair_dryer,
      :location, :lat, :long, :location_description
    ]
  end

  def model_params
    :room
  end

  def initial_value
    {
      user_id: current_user.id
    }
  end
end
