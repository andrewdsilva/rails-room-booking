class BookingsController < ApplicationController
  include ::CrudConcern

  private

  def base_class
    ::Booking
  end

  def object_class
    base_class.all
  end

  def strong_params
    [
      :start_date, :end_date, :num_guests, :room_id
    ]
  end

  def model_params
    :booking
  end

  def use_slug?
    false
  end
end
