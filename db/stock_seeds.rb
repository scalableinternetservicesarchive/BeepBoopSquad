require 'csv'
require_relative './data/users.csv'

#https://medium.com/dev-genius/how-to-seed-with-ruby-on-rails-%EF%B8%8F-1d2dceda3e7d
def seed_users
  csv_file_path = '/[project_path]/db/data/stocks.csv'
  puts 'Seeding users from #{csv_file_path}...'
  f = File.new(csv_file_path, 'r')
  csv = CSV.new(f)
  headers = csv.shift
  
  csv.each do |row|
    user_information = {
      name: row[1],
      symbol: row[1]
    }
    inv = User.create(user_information)
  end
  puts 'Seeding users from #{csv_file_path} done.'
end


"""

<request>
<dyn_variable name="authenticity_token" xpath="/html/head/meta[@name='csrf-token']/@content" />
<http url="/" method="GET"/>
</request>

<request subst="true"> 
<http url="/transactions" content_type = 'application/json' method="POST" 
contents_from_file="./transaction_buy.json">
</http>
</request>

<request subst="true"> 
<http url="/transactions" content_type = 'application/x-www-form-urlencoded' method="POST" 
contents='authenticity_token=%%_authenticity_token%%&amp;user_id=3&amp;stock_id=1&amp;num_shares=1&amp;transaction_type=buy'>
</http>
</request>
"""
