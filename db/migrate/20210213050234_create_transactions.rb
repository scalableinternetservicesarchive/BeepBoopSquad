class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :stock, null: false, foreign_key: true
      t.datetime :transaction_date
      t.bigint :cost_per_share
      t.bigint :num_shares
      t.string :type

      t.timestamps
    end
  end
end
