class StocksController < ApplicationController
  include ActionController::Caching
  skip_forgery_protection
  before_action :set_stock, only: %i[ show edit update destroy ]
  caches_page :index

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
    if stock_params[:symbol].nil? || stock_params[:symbol].empty?
      render json: { error: "Missing required stock symbol." }, status: :unprocessable_entity
    end
    @stock.symbol = @stock.symbol.upcase
    if params[:commit] == "Submit"
      # Normal Submit
    elsif params[:commit] == "Submit with Price API"
      @stock.fetch_stock_price
      puts 'stock fetch price: '
      puts @stock.share_price
    end
    respond_to do |format|
      if @stock.save
        expire_page :action => :index
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
        expire_page :action => :index
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
    expire_page :action => :index
  end

  def prd_seed_stocks
    require_relative '../../db/controller_stock_seeding'
    if params[:seed_id].nil?
      input = ""
    else
      input = params[:seed_id]
    end
      resp = seed_stocks(input)
    if !resp
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Unsuccessful seed. File stocks" + input.to_s + ".csv doesn't exist" }
        format.json { render json: {"message": "Unsuccessful seed. File stocks" + input.to_s + ".csv doesn't exist"  }, status: :unprocessable_entity}
      end
    else
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Seeded stocks with file stocks" + input.to_s + ".csv" }
      format.json { render json: {"message": "Seeded stocks with file stocks" + input.to_s + ".csv"}, status: :created }
    end
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
