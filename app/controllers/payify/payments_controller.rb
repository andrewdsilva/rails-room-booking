module Payify
  class PaymentsController < ApplicationController
    include ::Payify::PaymentsControllerConcern

    before_action :set_booking, only: [:complete]

    private

    def set_booking
      @booking = @payment.model
    end

  end
end
