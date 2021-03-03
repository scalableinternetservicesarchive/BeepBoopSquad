class AddUniqueConstraintToOwnerships < ActiveRecord::Migration[6.1]
  def change
    add_index :ownerships, [:user_id, :stock_id], unique: true
  end
end
