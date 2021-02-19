json.extract! transaction, :id, :user, :stock, :ownership, :cost_per_share, :num_shares, :transaction_type, :user_balance_change, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
