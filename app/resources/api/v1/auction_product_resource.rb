class Api::V1::AuctionProductResource < Api::V1::BaseResource
  attributes :id, :product_id, :creator_id, :price, :cost, :extra, :title, :winner_id, :created_at, :updated_at, :status, :start_at, :finish_at, :current_price
  has_many :orders

  filter :product_id, apply: ->(records, value, _options) {
    records.where("product_id = ?", value[0])
  }
end
