class ChangeExchangeTypeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :exchanges, :type, :exchange_type
    remove_column :exchanges, :exchange_date # Superfluous because of default timestamps
    remove_column :transactions, :transaction_date # Ditto
  end
end
