json.extract! exchange, :id, :user, :exchange_type, :amount, :created_at, :updated_at
json.url exchange_url(exchange, format: :json)
