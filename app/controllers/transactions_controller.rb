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

  def new
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      @owned_stocks = @user.stocks_ownership
    end
    @transaction = Transaction.new
  end

  # POST /transactions or /transactions.json
  def create
    stock_id = -1
    user = User.find(transaction_params[:user_id])
    if !is_numeric(transaction_params[:stock_id])
      stock_id = Stock.find_by symbol: transaction_params[:stock_id].upcase
    else
      stock_id = transaction_params[:stock_id]
    end
    stock = Stock.find_by id: (stock_id)
    if user.nil? || stock.nil?
      respond_to do |format|
      format.html {redirect_to new_transaction_path, notice: "Specified user or stock did not exist", status: :unprocessable_entity }
      format.json { render json: {error: "Specified user or stock did not exist"}, status: :unprocessable_entity }
      end
    end

    if session[:user_id].nil? || transaction_params[:user_id].to_i != session[:user_id].to_i
      respond_to do |format|
      format.html { redirect_to new_transaction_path, error: "Not authorized to perform this transaction", status: :unauthorized }
      format.json {render json: { error: "Not authorized to perform this transaction"}, status: :unauthorized }
      end
    end

    num_shares = transaction_params[:num_shares].to_i
    transaction_amount = num_shares * stock.share_price

    ownership_record = Ownership.find_or_initialize_by(stock: stock, user: user) #sometimes there are multiple stocks of same stock_id and user_id

    if ownership_record.num_shares.nil?
      ownership_record.num_shares = 0
    end

    @transaction = Transaction.new(cost_per_share: stock.share_price, num_shares: num_shares, stock: stock, user: user)

    case transaction_params[:transaction_type]
    when "buy"
      @transaction.transaction_type = :buy
      if user.cash_balance < transaction_amount
        respond_to do |format|
          format.html { redirect_to new_transaction_path, error: "Not enough money to complete the transaction", status: :forbidden }
          format.json { render json: {error: "Not enough money to complete the transaction" }, status: :forbidden }
        end
      end
      ownership_record.num_shares += num_shares
      user.cash_balance -= transaction_amount
    when "sell"
      @transaction.transaction_type = :sell
      if ownership_record.num_shares < num_shares
        respond_to do |format|
        format.html { redirect_to new_transaction_path, error: "Not enough shares owned to sell.", status: :forbidden }
        format.json { render json: {error: "Not enough shares owned to sell."}, status: :forbidden }
        end
      end
      ownership_record.num_shares -= num_shares
      user.cash_balance += transaction_amount
    else
      respond_to do |format|
      format.html { redirect_to new_transaction_path, error: "Invalid transaction type.", status: :unprocessable_entity }
      format.json { render json: {error: "Invalid transaction type."}, status: :unprocessable_entity }
      end
    end

    respond_to do |format|
      user.errors.full_messages
      @transaction.errors.full_messages
      ownership_record.errors.full_messages
      if @transaction.save && user.save && ownership_record.save
        puts 'successful transaction!!!!'
        format.html { redirect_to root_path, notice: "Transaction was successfully created." } #status: :created }
        format.json { render :show, status: :created, location: @transaction }
      else
        puts 'bad transaction'
        puts transaction_params
        format.html { render new_transaction_path, notice: "Transaction unsuccessful. Please try again" }
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
    
    def is_numeric(input)
      return true if input =~ /\A\d+\Z/
      true if Float(input) rescue false
    end
end
