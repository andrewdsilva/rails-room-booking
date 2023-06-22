module Payify
  class PaymentsController < ApplicationController
    include ::Payify::PaymentsControllerConcern
  end
end
