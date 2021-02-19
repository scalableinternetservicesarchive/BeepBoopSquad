class TransactionsController < ApplicationController
  skip_forgery_protection
  before_action :set_transaction, only: %i[ show ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # POST /transactions or /transactions.json
  def create
    user = User.find(transaction_params[:user_id])
    stock = Stock.find(transaction_params[:stock_id])
    if user.nil? || stock.nil?
      return render json: {error: "Specified user or stock did not exist"}, status: :unprocessable_entity
    end
    num_shares = transaction_params[:num_shares]
    transaction_amount = num_shares * stock.share_price
    ownership_record = Ownership.find_or_initialize_by(stock: stock, user: user)
    if ownership_record.num_shares.nil?
      ownership_record.num_shares = 0
    end
    @transaction = Transaction.new(cost_per_share: stock.share_price, num_shares: num_shares, stock: stock, user: user)

    case transaction_params[:transaction_type]
    when "buy"
      @transaction.transaction_type = :buy
      if user.cash_balance < transaction_amount
        return render json: {error: "Not enough money to complete the transaction"}, status: :forbidden
      end
      ownership_record.num_shares += num_shares
      user.cash_balance -= transaction_amount
    when "sell"
      @transaction.transaction_type = :sell
      if ownership_record.num_shares < num_shares
        return render json: {error: "Not enough shares owned to sell."}, status: :forbidden
      end
      ownership_record.num_shares -= num_shares
      user.cash_balance += transaction_amount
    else
      return render json: {error: "Invalid transaction type."}, status: :unprocessable_entity
    end


    respond_to do |format|
      if @transaction.save && user.save && ownership_record.save
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
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
      params.require(:transaction).permit(:user_id, :stock_id, :num_shares, :transaction_type)
    end
end
