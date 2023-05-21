class CreateBooking < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date

      t.integer :num_guests
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
