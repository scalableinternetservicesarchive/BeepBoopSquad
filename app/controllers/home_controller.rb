class HomeController < ApplicationController
  def index
    @cash = 500
    @portfolio_value = 1000
    @stocks = Stock.all
  end
end
