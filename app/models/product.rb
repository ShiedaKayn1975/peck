class Product < ApplicationRecord
  include Actionable

  action :new_campaign do
    label "New campaign"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      true
    end

    commitable? do |object, context|
      true
    end

    commit do |object, context|
      data = context[:data]

      raise InvalidDataError.new("Price and Title cannot be blank!") if (data["price"].blank? || data["title"].blank?)

      new_auction_product = AuctionProduct.new do |new_auction|
        new_auction.product_id = object.id
        new_auction.creator_id = context[:actor].id
        new_auction.price = data["price"]
        new_auction.title = data["title"]
        new_auction.status = AuctionProduct::Status::UNPUBLISH
      end

      new_auction_product.save
    end
  end
end
