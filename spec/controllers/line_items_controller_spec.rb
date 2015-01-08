require 'spec_helper'

describe LineItemsController do
  include CurrentCart
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

end
