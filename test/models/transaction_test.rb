# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  cost_per_share   :bigint
#  num_shares       :bigint
#  transaction_date :datetime
#  type             :string
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
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
