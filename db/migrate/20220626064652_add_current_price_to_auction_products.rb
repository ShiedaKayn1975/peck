class AddCurrentPriceToAuctionProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :auction_products, :current_price, :bigint
  end
end
