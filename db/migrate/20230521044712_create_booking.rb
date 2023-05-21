class CreateBooking < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date

      t.integer :num_guests
      t.references :room
      t.references :user

      t.timestamps
    end
  end
end
