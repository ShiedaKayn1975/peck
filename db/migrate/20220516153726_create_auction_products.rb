class CreateAuctionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :auction_products do |t|
      t.bigint :product_id
      t.bigint :creator_id
      t.float :price
      t.float :cost
      t.jsonb :extra
      t.string :title
      t.bigint :winner

      t.timestamps
    end
  end
end
