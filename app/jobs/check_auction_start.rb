class CheckAuctionStart < ApplicationJob
  queue_as :default

  sidekiq_options retry: 0

  def perform
    auctions = AuctionProduct.where("start_at < ? and status = ?", Time.now, 'waiting')
    auctions.update_all(status: 'active')
  end
end