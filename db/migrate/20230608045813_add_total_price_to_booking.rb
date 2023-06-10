class AddTotalPriceToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :total_ht, :decimal, default: 0.0
    add_column :bookings, :total_ttc, :decimal, default: 0.0
  end
end
