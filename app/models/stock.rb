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
class Stock < ApplicationRecord


  def fetch_stock_price
    url = URI.parse('https://data.alpaca.markets/v1/last_quote/stocks/' + params[:stock][:symbol])
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # need for HTTPS
    req = Net::HTTP::Get.new(url.request_uri)
    req['APCA-API-KEY-ID'] = ENV['APCA-API-KEY-ID']
    req['APCA-API-SECRET-KEY'] = ENV['APCA-API-SECRET-KEY']
    req['Accept'] = 'application/json'
    response = http.request(req)
    response_json = JSON.parse(response.body)
    self.share_price = response_json['last']['bidprice']
  end
end
