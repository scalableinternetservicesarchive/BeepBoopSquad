require 'csv'

def seed_stocks
  csv_file_path = Rails.root.join('db', 'data', 'stocks.csv')
  puts 'Seeding stocks from #{csv_file_path}...'
  f = File.new(csv_file_path, 'r')
  csv = CSV.new(f)
  headers = csv.shift
  
  csv.each do |row|
    stock_information = {
      symbol: row[0],
      name: row[1],
      share_price: row[2]
    }
    Stock.create_with(stock_information).find_or_create_by(symbol: row[0])
  end
  puts 'Seeding stocks from #{csv_file_path} done.'
end