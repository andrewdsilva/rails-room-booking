class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :slug
      t.string :title
      t.text :description
      t.integer :room_type

      t.integer :num_guests

      t.integer :num_rooms
      t.integer :num_beds
      t.integer :num_baths

      t.integer :day_price

      t.boolean :self_check_in, default: true
      t.boolean :parking, default: true
      t.boolean :kitchen, default: true
      t.boolean :washer, default: true
      t.boolean :dryer, default: true
      t.boolean :dishwasher, default: true
      t.boolean :wifi, default: true
      t.boolean :tv, default: true
      t.boolean :bathroom_essentials, default: true
      t.boolean :bedroom_comforts, default: true
      t.boolean :coffee_maker, default: true
      t.boolean :hair_dryer, default: true

      t.string :location
      t.float :lat
      t.float :long
      t.text :location_description

      t.references :user
      t.timestamps
    end
  end
end
