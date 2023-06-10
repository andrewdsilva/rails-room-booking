class CreateSettingsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.references :user

      t.decimal :vat, default: 0.2

      t.timestamps
    end
  end
end
