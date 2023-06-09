class AddCancelToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :canceled_at, :datetime, null: true
  end
end
