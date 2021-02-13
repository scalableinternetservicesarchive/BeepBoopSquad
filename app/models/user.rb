# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  cash_balance :bigint
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
end
