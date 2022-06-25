class AddStartAtToAuctionProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :auction_products, :finish_at, :datetime
    add_column :auction_products, :start_at, :datetime
  end
end
