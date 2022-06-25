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

      start_at = data["start_at"].to_datetime
      raise InvalidDataError.new("Invalid start at time!") if start_at <= Time.now
      finish_at = start_at + 12.hours

      new_auction_product = AuctionProduct.new do |new_auction|
        new_auction.product_id = object.id
        new_auction.creator_id = context[:actor].id
        new_auction.price = data["price"]
        new_auction.title = data["title"]
        new_auction.status = AuctionProduct::Status::WAITING
        new_auction.start_at = start_at
        new_auction.finish_at = finish_at
      end

      new_auction_product.save
    end
  end

  action :cancel_auction do
    label "Cancel auction"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      object.creator_id == context[:actor].id
    end

    commitable? do |object, context|
      true
    end

    commit do |object, context|
      data = context[:data]
      auction = AuctionProduct.find_by_id(data['auction_id'])

      raise InvalidDataError.new("You can only cancel waiting auction!") unless auction.status == AuctionProduct::Status::WAITING

      auction.status = AuctionProduct::Status::CANCELLED
      auction.save
    end
  end
end
