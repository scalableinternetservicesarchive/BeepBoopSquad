class RemovePvhDateRecordedColumn < ActiveRecord::Migration[6.1]
  def change
    # The column is superfluous because we have a created_at timestamp by default
    remove_column :portfolio_value_histories, :date_recorded
  end
end
