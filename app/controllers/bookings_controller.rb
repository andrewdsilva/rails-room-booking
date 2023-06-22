class BookingsController < ApplicationController
  include ::CrudConcern

  before_action :stripe_init_intent, only: [:show]

  def cancel
    set_object

    authorize @object

    @object.cancel!

    redirect_to_show(@object)
  end

  private

  def base_class
    ::Booking
  end

  def object_class
    return base_class.none if current_user.nil?

    base_class.where(user_id: current_user.id)
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

  def stripe_init_intent
    if @object.payment_pending?
      @object.payment.stripe_init_intent
    end
  end
end
