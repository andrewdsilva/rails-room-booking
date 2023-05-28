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

      t.boolean :self_check_in, default: false
      t.boolean :parking, default: false
      t.boolean :kitchen, default: false
      t.boolean :washer, default: false
      t.boolean :dryer, default: false
      t.boolean :dishwasher, default: false
      t.boolean :wifi, default: false
      t.boolean :tv, default: false
      t.boolean :bathroom_essentials, default: false
      t.boolean :bedroom_comforts, default: false
      t.boolean :coffee_maker, default: false
      t.boolean :hair_dryer, default: false

      t.string :location
      t.float :lat
      t.float :long
      t.text :location_description

      t.references :user
      t.timestamps
    end
  end
end
