# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  cash_balance :bigint
#  name         :string
#  password     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
