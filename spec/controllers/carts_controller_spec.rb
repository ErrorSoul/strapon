require 'spec_helper'

describe CartsController do
  let!(:cart){FactoryGirl.create(:cart)}
  let!(:author) {FactoryGirl.create(:author)}
  let!(:post1) {FactoryGirl.create(:post, author: author)}
  let!(:post2) {FactoryGirl.create(:post, author: author)}
  before do 
    session[:cart_id] = cart.id
    cart.add_product(post1.id)
    cart.add_product(post2.id)
    cart.save 
    cart.reload
  end



  describe "show method" do 
    it "should return current cart" do 
      posts = cart.line_items.map(&:post)
      get :show, id: 1
      expected_json = {posts: posts}.to_json
      expect(response.body).to eq expected_json
    end
  end
end
