# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  cost_per_share   :decimal(15, 2)
#  num_shares       :bigint
#  transaction_type :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stock_id         :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_transactions_on_stock_id  (stock_id)
#  index_transactions_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (stock_id => stocks.id)
#  fk_rails_...  (user_id => users.id)
#
class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  enum transaction_type: [:buy, :sell]
  validate :user_can_make_transaction
  after_create :perform_transaction

  def user_balance_change
    num_shares * cost_per_share
  end

  def ownership
    Ownership.find_by user: user, stock: stock
  end

  def user_can_make_transaction
    if self.user.nil?
      errors.add :base, "No user present."
      return
    end
    self.cost_per_share = stock.share_price
    case transaction_type
    when "buy"
      if user.cash_balance - user_balance_change < 0
        errors.add :num_shares, "User's cash balance insufficient to complete the transaction."
      end
    when "sell"
      if ownership.nil? || ownership.num_shares < num_shares
        errors.add :num_shares, "User does not own enough shares to sell."
      end
    else
      errors.add :transaction_type, "Invalid transaction type. Must be 'buy' or 'sell'."
    end
  end

  def perform_transaction
    ownership_record = ownership
    case transaction_type
    when "buy"
      user.increment! :cash_balance, -user_balance_change
      ownership_record = ownership_record || Ownership.create(user: user, stock: stock, num_shares: 0)
      ownership_record.increment! :num_shares, num_shares
    when "sell"
      user.increment! :cash_balance, user_balance_change
      ownership_record.increment! :num_shares, -num_shares
    end
  end
end
