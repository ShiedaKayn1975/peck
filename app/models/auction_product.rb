class AuctionProduct < ApplicationRecord
  module Status
    UNPUBLISH = 'unpublish'
    ACTIVE = 'active'
    CANCELLED = 'cancelled'
  end
  
  enumerize :status,
    in: Status.constants.map { |const| Status.const_get(const) }, 
    predicates: true
end
