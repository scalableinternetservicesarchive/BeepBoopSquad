class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    @stock = Stock.new(stock_params)
    puts params[:commit]
    if params[:commit] == "Submit"
      # Normal Submit
    elsif params[:commit] == "Generate from API"
      require "net/http"
      require "uri"
      url = URI.parse('https://data.alpaca.markets/v1/last_quote/stocks/' + params[:stock][:symbol])
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true #need for HTTPS
      req = Net::HTTP::Get.new(url.request_uri)
      req['APCA-API-KEY-ID'] = ENV['APCA-API-KEY-ID']
      req['APCA-API-SECRET-KEY'] = ENV['APCA-API-SECRET-KEY']
      req['Accept'] = 'application/json'
      response = http.request(req)
      response_json = JSON.parse(response.body)
      @stock.share_price = response_json['last']['bidprice'] #this will be a float, must migrate stock to float
      # curl API
    end
    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:name, :symbol, :share_price)
    end
end
