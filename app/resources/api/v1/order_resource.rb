class Api::V1::OrderResource < Api::V1::BaseResource
  attributes :id, :code, :shipping_address, :total, :shipping_fee, :phone, :email, :paid_at, :cancelled, :cancelled_at, 
    :cancelled_reason, :currency, :note, :auction_id, :product_id, :owner_id, :customer_id, :created_at, :updated_at, :status
  
  has_one :auction_product
  has_one :product
end