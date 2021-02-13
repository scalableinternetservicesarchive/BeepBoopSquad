# == Schema Information
#
# Table name: ownerships
#
#  id         :bigint           not null, primary key
#  num_shares :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stock_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ownerships_on_stock_id  (stock_id)
#  index_ownerships_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (stock_id => stocks.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class OwnershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
