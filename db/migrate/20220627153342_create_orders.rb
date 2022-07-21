class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.jsonb :shipping_address
      t.float :total
      t.float :shipping_fee
      t.string :phone
      t.string :email
      t.datetime :paid_at
      t.boolean :cancelled
      t.datetime :cancelled_at
      t.string :cancelled_reason
      t.string :currency
      t.string :note
      t.bigint :auction_id
      t.bigint :product_id

      t.timestamps
    end
  end
end
