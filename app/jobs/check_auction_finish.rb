class CheckAuctionFinish < ApplicationJob
    queue_as :default
  
    sidekiq_options retry: 0
  
    def perform
      auctions = AuctionProduct.where("finish_at > ? and status = ?", Time.now, 'active')
      auctions.update_all(status: 'finished')
    end
  end