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

require 'spec_helper'

describe LineItem do
  let!(:post) {FactoryGirl.create(:post)}
  let!(:post1) {FactoryGirl.create(:post, author_id: 3)}
  let!(:post2) {FactoryGirl.create(:post, author_id: 3)}
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
  describe "get_indexes" do 
    before do 
      @cart = Cart.create
      @arr = (1..10).to_a
      @one_arr = [1]
    end
    it "should return three nil" do
      arr_nil = [nil, 0, nil]
      expect(@cart.get_indexes(@arr, 11)).to eq arr_nil
    end
    it "should return ind, forward ind" do
      new_arr = [0, 1, nil]
      expect(@cart.get_indexes(@arr, 1)).to eq new_arr
    end
    it "should return ind, nil, back ind" do
      new_arr = [9, nil, 8]
      expect(@cart.get_indexes(@arr, 10)).to eq new_arr
    end
    it "should return ind, forward ind, back ind" do
      new_arr = [1, 2, 0]
      expect(@cart.get_indexes(@arr, 2)).to eq new_arr
    end

    it "should return ind, nil, nil when post in cart w one post" do
      new_arr  = [0, nil, nil]
      expect(@cart.get_indexes(@one_arr, 1)).to eq new_arr
    end
    
  end

  describe "has_post" do
    before do 
      @cart = Cart.create
      @cart.add_product(post.id)
      @cart.save
      @cart.reload
    end

    it "should return all nil when post not in cart " do
      expect(@cart.has_post(post1)).to eq [nil, post.id, nil]
    end

    it "should return  ind, forward ind and nil   when post in cart w one post" do 
      expect(@cart.has_post(post)).to eq  [0, nil, nil]
    end

    it "should return ind, nil and back ind when post is last elem in cart" do
      @cart.add_product(post1.id)
      @cart.save
      @cart.reload
      expect(@cart.has_post(post1)).to eq [1, nil, post.id]
    end


    
    it "should return ind, forward and back ind when post  in cart" do
      @cart.add_product(post1.id)
      @cart.add_product(post2.id)
      @cart.save
      @cart.reload
      expect(@cart.has_post(post1)).to eq [1, post2.id, post.id]
    end
  end
      
      
end
