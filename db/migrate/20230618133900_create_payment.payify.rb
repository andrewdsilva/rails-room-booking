# This migration comes from payify (originally 20230611124944)
class CreatePayment < ActiveRecord::Migration[7.0]
  def change
    create_table :payify_payments do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :status, default: 0, null: false
      t.integer :payment_method
      t.string :transaction_id
      t.datetime :paid_at
      t.string :model_type
      t.integer :model_id

      t.timestamps
    end
  end
end
