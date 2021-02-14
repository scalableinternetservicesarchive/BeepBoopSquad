json.extract! user, :id, :name, :cash_balance, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
