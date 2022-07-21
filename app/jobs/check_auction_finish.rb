class CheckAuctionFinish < ApplicationJob
  queue_as :default

  sidekiq_options retry: 0

  def perform
    auctions = AuctionProduct.where("finish_at < ? and status = ?", Time.now, 'active')
    auctions.update_all(status: 'finished')

    auctions.each do |auction|
      if auction.winner_id
        auction.cost = auction.current_price/10
        order = Order.new
        
        order.code = 'ORD-' + auction.product_id.to_s + '-' + auction.id.to_s
        order.total = auction.cost + auction.current_price
        order.shipping_fee = 0
        order.currency = 'VND'
        order.auction_id = auction.id
        order.product_id = auction.product_id
        order.owner_id = auction.creator_id
        order.customer_id = auction.winner_id
        order.status = 'initial'

        order.save
        auction.save
      end
    end
  end
end