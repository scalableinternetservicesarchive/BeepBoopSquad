require 'csv'

def seed_users(id)
  csv_file_path = Rails.root.join('db', 'data', 'users' + id + '.csv')
  puts 'Seeding users from #{csv_file_path}...'
  if !File.exist?(csv_file_path)
    return false
  end
  f = File.new(csv_file_path, 'r')
  csv = CSV.new(f)
  headers = csv.shift
  
  csv.each do |row|
    stock_information = {
      name: row[0],
      password: 'password',
      cash_balance: row[2]
    }
    User.create_with(stock_information).find_or_create_by(name: row[0])
  end
  puts 'Seeding users from #{csv_file_path} done.'
  return true
end