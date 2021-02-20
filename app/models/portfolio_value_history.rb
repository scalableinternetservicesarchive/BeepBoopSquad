# == Schema Information
#
# Table name: portfolio_value_histories
#
#  id              :bigint           not null, primary key
#  date_recorded   :datetime
#  portfolio_value :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_portfolio_value_histories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PortfolioValueHistory < ApplicationRecord
  belongs_to :user
end
