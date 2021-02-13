# == Schema Information
#
# Table name: portfolio_value_histories
#
#  id              :bigint           not null, primary key
#  date_recorded   :datetime
#  portfolio_value :bigint
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
require "test_helper"

class PortfolioValueHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
