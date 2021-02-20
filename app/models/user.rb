# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  cash_balance :decimal(15, 2)
#  name         :string
#  password     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class User < ApplicationRecord
  has_many :ownerships
  has_many :stocks, through: :ownerships
  has_many :transactions
  has_many :portfolio_value_histories
  has_many :exchanges

  def portfolio_value
    total_value = self.cash_balance
    portfolio_ownerships = self.ownerships.includes(:stock)
    portfolio_ownerships.each do |ownership|
      total_value += ownership.num_shares * ownership.stock.share_price
    end
    total_value
  end
end
