require 'spec_helper'

describe LineItem do
  let!(:post) {FactoryGirl.create(:post)}
  let!(:post1) {FactoryGirl.create(:post, author_id: 3)}
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


  describe "line_items_length" do
    before do 
      @cart = Cart.create
    end
    it "should return nil when cart is empty" do
      expect(@cart.line_items_length).to eq nil
    end

    it "should return 0 when cart has one post" do
      @cart.add_product(post.id)
      @cart.save
      @cart.reload
      expect(@cart.line_items_length).to eq 0 
    end

    it "should return 1 when cart line_items.length> 1" do
      @cart.add_product(post.id)
      @cart.add_product(post1.id)
      @cart.save
      @cart.reload
      expect(@cart.line_items_length).to eq 1 
    end

  end

  describe "has_post?" do
    before do 
      @cart = Cart.create
      @cart.add_product(post.id)
      @cart.save
      @cart.reload
    end

    it "should return nil when post not in cart " do
      expect(@cart.has_post?(post1)).to eq false
    end

    it "should return true when post in cart" do 
      expect(@cart.has_post?(post)).to eq true
    end
  end
      
      
end
