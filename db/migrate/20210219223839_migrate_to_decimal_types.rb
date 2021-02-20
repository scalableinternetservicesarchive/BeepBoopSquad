class MigrateToDecimalTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :cash_balance, :decimal, scale: 2, precision: 15
    change_column :stocks, :share_price, :decimal, scale: 2, precision: 15
    change_column :transactions, :cost_per_share, :decimal, scale: 2, precision: 15
    change_column :exchanges, :amount, :decimal, scale: 2, precision: 15
    change_column :portfolio_value_histories, :portfolio_value, :decimal, scale: 2, precision: 15
  end
end
