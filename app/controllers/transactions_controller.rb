class TransactionsController < ApplicationController
  skip_forgery_protection
  before_action :set_transaction, only: %i[ show ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all.includes(:stock, :user)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  def new
    unless current_user.nil?
      @owned_stocks = current_user.stocks_ownership.where("num_shares > ?", 0)
    end
    @transaction = Transaction.new
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(user_id: transaction_params[:user_id], stock_id: transaction_params[:stock_id],
                                   num_shares: transaction_params[:num_shares],
                                   transaction_type: transaction_params[:transaction_type])
    if params[:stock_symbol].present?
      @transaction.stock = Stock.find_by_symbol params[:stock_symbol] || Stock.first
    end
    if @transaction.user.nil?
      @transaction.user = current_user
    end
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to root_path, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, notice: "Transaction unsuccessful. Please try again", status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:user_id, :stock_id, :num_shares, :transaction_type, :stock_symbol)
  end
end
