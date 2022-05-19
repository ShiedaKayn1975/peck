class AddStatusToAuctionProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :auction_products, :status, :string
  end
end
