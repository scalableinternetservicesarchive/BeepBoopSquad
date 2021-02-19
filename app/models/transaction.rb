# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  cost_per_share   :bigint
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

  def user_balance_change
    type_multiplier = self.sell? ? 1 : -1
    self.num_shares * self.cost_per_share * type_multiplier
  end

  def ownership
    Ownership.find_by user: self.user, stock: self.stock
  end
end
