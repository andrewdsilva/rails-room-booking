# This migration comes from payify (originally 20230617052430)
class AddStripePaymentIntentId < ActiveRecord::Migration[7.0]
  def change
    add_column :payify_payments, :stripe_payment_inent_id, :string
    add_column :payify_payments, :stripe_client_secret, :string
  end
end
