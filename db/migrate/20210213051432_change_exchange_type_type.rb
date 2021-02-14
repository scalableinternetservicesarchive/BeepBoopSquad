class ChangeExchangeTypeType < ActiveRecord::Migration[6.1]
  def change
    remove_column :exchanges, :type
    add_column :exchanges, :type, :integer
  end
end
