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
class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :stock
end
