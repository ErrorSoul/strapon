require 'spec_helper'

describe LineItem do
  let!(:post) {FactoryGirl.create(:post)}
  let!(:cart) {FactoryGirl.create(:cart)}
  let!(:posts) {FactoryGirl.create(:author_with_posts)}
  before do 
    @line_item = cart.line_items.build(post: post)
  end


  subject {@line_item}
  it {should respond_to(:cart) }
  it {should respond_to(:post)}
  it {should be_valid}

  describe "cart add_post" do 
    before do 
      @cart  = Cart.create
      
    end
    it "should add new line_items" do
      expect {@cart.add_product(post.id)}.to change(LineItem, :count).by(0)
    end
    
    it "should add new  line_items to cart" do
      expect {@cart.add_product(post.id)}.to change(@cart.line_items, :count).by(0)
    end
    
    
  end
      
end
