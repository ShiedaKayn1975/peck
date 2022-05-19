class Api::V1::AuctionProductResource < Api::V1::BaseResource
  attributes :id, :product_id, :creator_id, :price, :cost, :extra, :title, :winner, :created_at, :updated_at, :status

  filter :product_id, apply: ->(records, value, _options) {
    records.where("product_id = ?", value[0])
  }
end
