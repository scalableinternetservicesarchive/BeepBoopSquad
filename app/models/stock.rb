# == Schema Information
#
# Table name: stocks
#
#  id          :bigint           not null, primary key
#  name        :string
#  share_price :decimal(15, 2)
#  symbol      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "net/http"
require "uri"

class Stock < ApplicationRecord
  validates :symbol, presence: true, uniqueness: { case_sensitive: false }
  has_many :ownerships, dependent: :delete_all
  #after_update :update_ownerships

  def fetch_stock_price
    url = URI.parse('https://data.alpaca.markets/v1/last_quote/stocks/' + self.symbol)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # need for HTTPS
    req = Net::HTTP::Get.new(url.request_uri)
    req['APCA-API-KEY-ID'] = ENV['APCA_API_KEY_ID']
    req['APCA-API-SECRET-KEY'] = ENV['APCA_API_SECRET_KEY']
    req['Accept'] = 'application/json'
    response = http.request(req)
    puts 'response code'
    puts response.code
    if response.code != 200 && response.code != 201
    else
      puts 'response body'
      response_json = JSON.parse(response.body)
      puts response_json
      self.share_price = response_json.dig('last', 'bidprice') || self.share_price
    end
  end

  """
  #the below is not needed if we aren't doing russian doll caching
  def update_ownerships
    Ownership.where(stock: self).touch_all
  end
  """
end
