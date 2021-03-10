class AddStockSymbolIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :stocks, :symbol
  end
end