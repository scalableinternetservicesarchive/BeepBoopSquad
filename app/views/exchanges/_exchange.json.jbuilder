json.extract! exchange, :id, :user_id, :type, :amount, :created_at, :updated_at
json.url exchange_url(exchange, format: :json)