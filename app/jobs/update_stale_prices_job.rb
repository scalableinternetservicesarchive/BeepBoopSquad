STOCK_BATCH_SIZE = 150 # Just to stay a bit under the rate limit

class UpdateStalePricesJob < BackgroundJob
  def perform
    request_threads = []
    Stock.transaction do
      current_batch_offset = 0
      loop do
        stocks = Stock.offset(current_batch_offset).first(STOCK_BATCH_SIZE)
        stocks.each do |stock|
          # We use threading to make these requests simultaneously rather than in sequence.
          request_threads << Thread.new do
            stock.fetch_stock_price
            stock.save
          end
        end
        break if stocks.size < STOCK_BATCH_SIZE
        current_batch_offset += STOCK_BATCH_SIZE
        sleep(60) # Cope with rate limiting of API
      end
    end
    request_threads.each &:join
    UpdateStalePricesJob.perform_in(60 * 60) # Schedule next update for an hour from now
  end
end