class AuctionProduct < ApplicationRecord
  has_many :orders, class_name: 'Order', foreign_key: :auction_id
  include Actionable

  module Status
    WAITING = 'waiting'
    ACTIVE = 'active'
    FINISHED = 'finished'
    CANCELLED = 'cancelled'
  end
  
  enumerize :status,
    in: Status.constants.map { |const| Status.const_get(const) }, 
    predicates: true

  action :comment_auction do
    label "Comment auction"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      true
    end

    commitable? do |object, context|
      object.status == 'active'
    end

    commit do |object, context|
      data = context[:data]
      if object.finish_at >= Time.now
        if data['type'] == 'add_price'
          if object.creator_id == context[:actor].id
            raise InvalidDataError.new("Bạn không thể thêm giá cho sản phẩm của mình!")
          else
            price = data['content'].to_f
          
            if price > (object.current_price || 0)
              object.current_price = price
              object.winner_id = context[:actor].id
              object.save
            else
              raise InvalidDataError.new("Bạn không thể thêm giá thấp hơn")
            end
          end
        end
      else
        raise InvalidDataError.new("Phiên đấu giá đã kết thúc")
      end
    end
  end
end
