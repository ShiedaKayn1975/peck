class AuctionProduct < ApplicationRecord
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
        true
      end
  
      commit do |object, context|
      end
    end
end
