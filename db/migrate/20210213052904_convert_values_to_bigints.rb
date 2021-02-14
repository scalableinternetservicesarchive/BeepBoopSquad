class ConvertValuesToBigints < ActiveRecord::Migration[6.1]
  def change
    change_column :stocks, :share_price, :bigint
    change_column :users, :cash_balance, :bigint
    change_column :ownerships, :num_shares, :bigint
  end
end
