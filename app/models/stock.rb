# == Schema Information
#
# Table name: stocks
#
#  id          :bigint           not null, primary key
#  name        :string
#  share_price :decimal(15, 2)
#  symbol      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Stock < ApplicationRecord
end
