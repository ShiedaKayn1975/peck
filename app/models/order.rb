class Order < ApplicationRecord
    belongs_to :auction_product, class_name: 'AuctionProduct', foreign_key: :auction_id
    belongs_to :product, class_name: 'Product', foreign_key: :product_id
end
