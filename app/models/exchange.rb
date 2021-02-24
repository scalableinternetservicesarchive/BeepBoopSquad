# == Schema Information
#
# Table name: exchanges
#
#  id            :bigint           not null, primary key
#  amount        :decimal(15, 2)
#  exchange_type :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_exchanges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Exchange < ApplicationRecord
  belongs_to :user
  enum exchange_type: [:deposit, :withdrawal]
  validate :user_can_make_exchange
  after_create :perform_exchange

  def user_can_make_exchange
    case exchange_type
    when "withdrawal"
      if amount > user.cash_balance
        errors.add "Cannot withdraw more money than is currently in your account."
      end
    end
  end

  def perform_exchange
    exchange_multiplier = deposit? ? 1 : -1
    user.increment(:cash_balance, amount * exchange_multiplier).save!
  end
end
