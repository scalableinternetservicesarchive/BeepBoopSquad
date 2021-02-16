class UpdateStockPriceAttrType < ActiveRecord::Migration[6.1]
  def change
    change_column :stocks, :share_price, :real
  end
end
