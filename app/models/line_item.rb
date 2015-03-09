# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  cart_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class LineItem < ActiveRecord::Base
  belongs_to :post
  belongs_to :cart
end
