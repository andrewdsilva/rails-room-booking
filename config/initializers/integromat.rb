require "integromat"

Integromat.configure do |c|
  uri = ENV["INTEGROMAT_BASE_URI"]
  booking_hook = ENV["INTEGROMAT_BOOKING_HOOK"]

  c.web_hooks = { booking: booking_hook } if booking_hook.present?
  c.base_uri = uri if uri.present?
end
