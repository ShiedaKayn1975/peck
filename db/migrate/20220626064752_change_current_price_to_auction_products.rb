class ChangeCurrentPriceToAuctionProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :auction_products, :current_price
    add_column :auction_products, :current_price, :float
  end
end
