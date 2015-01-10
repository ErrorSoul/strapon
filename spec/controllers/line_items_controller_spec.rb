require 'spec_helper'

describe LineItemsController do
  include CurrentCart
  let!(:cart){FactoryGirl.create(:cart)}
  let!(:author){FactoryGirl.create(:author)}
  let!(:post1) {FactoryGirl.create(:post, author: author)}
  let!(:post2) {FactoryGirl.create(:post, author: author, title: "Ahmed")}

  describe "create method" do  
    it "should inc LineItem's count" do 
      expect do 
        post :create, line_item: {post_id: post1.id}
      end.to change(LineItem, :count).by(1)
    end


    it "should return ok message" do
       post :create, line_item: {post_id: post1.id}
      expected_json = { message: "OK"}.to_json
      expect(response.body).to eq expected_json
    end

     it "should add only one post to cart" do 
     
      
      post :create, line_item: { post_id: post1.id}
      post :create, line_item: {post_id: post1.id}
      
      expect((assigns :cart).line_items.count).to  eq 1
      
      
    end


     it "should add only one post to cart" do 
     
      
      post :create, line_item: { post_id: post1.id}
      post :create, line_item: {post_id: post2.id}
      
      expect((assigns :cart).line_items.count).to  eq 2
      
      
    end


  
  end

  describe "destroy method" do 
    before do 
      session[:cart_id] = cart.id
      cart.add_product(post1.id)
      cart.add_product(post2.id)
      cart.save
      cart.reload
    end

    it "destroy should return succesful message" do
      delete :destroy, id: post1.id
      expected_json = {message: "Line item deleted"}.to_json
      expect(response.body).to eq expected_json
    end


    it " destroy should decr line items count" do
      expect do 
        delete :destroy, id: post1.id 
      end.to change(LineItem, :count).by(-1)
    end

    it "should decr cart's line items" do
      expect do 
        delete :destroy, id: post1.id 
      end.to change(cart.line_items, :count).by(-1)
    end


    it "should destroy line item w post1" do
       
      delete :destroy, id: post1.id 
      
      expect(cart.line_items.count).to eq(1)
      expect(cart.line_items.first.post.id).to eq post2.id
    end
     
  end
      

end
