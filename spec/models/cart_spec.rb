require 'spec_helper'

describe Cart do
  before do
    @cart = Cart.create
  end
  
  subject {@cart}
  it {should respond_to(:user_id)}
  it {should be_valid}

end
