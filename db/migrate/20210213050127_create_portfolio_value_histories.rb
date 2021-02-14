class CreatePortfolioValueHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_value_histories do |t|
      t.bigint :portfolio_value
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :date_recorded

      t.timestamps
    end
  end
end
