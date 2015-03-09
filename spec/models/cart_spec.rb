# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Cart do
  before do
    @cart = Cart.create
  end
  
  subject {@cart}
  it {should respond_to(:user_id)}
  it {should be_valid}

end
