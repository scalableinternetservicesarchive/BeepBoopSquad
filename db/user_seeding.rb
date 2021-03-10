require 'csv'

def seed_users
  csv_file_path = Rails.root.join('db', 'data', 'users.csv')
  puts 'Seeding users from #{csv_file_path}...'
  f = File.new(csv_file_path, 'r')
  csv = CSV.new(f)
  headers = csv.shift
  
  csv.each do |row|
    stock_information = {
      name: row[0],
      password: row[1],
      cash_balance: row[2]
    }
    User.create_with(stock_information).find_or_create_by(name: row[0])
  end
  puts 'Seeding users from #{csv_file_path} done.'
end