require 'spec_helper'
require "pry"
describe CommentsController do
  let!(:poster){FactoryGirl.create(:post)}
  let!(:comment){FactoryGirl.create(:comment, post_id: poster.id, commentable: poster)}


  describe 'create method' do
    it "should create new comment for post" do
      
      post :create, comment: {name: 'New name', text: "New text",
                              commentable_id: poster.id, commentable_type: poster.class.name, post_id: poster.id}
      
      
      expected_json = {message: "Your comment saved"}.to_json
      expect(response.body).to eq expected_json
    end 

    it "should inc comment by 1 for post" do
      expect do 
      post :create, comment: {name: 'New name', text: "New text",
                              commentable_id: poster.id, commentable_type: poster.class.name, post_id: poster.id}
      
      
      end.to change(Comment, :count).by(1)
    end 

    it "should inc child by 1 for post" do
      
      expect do 
      post :create, comment: {name: 'New name', text: "New text",
                              commentable_id: poster.id, commentable_type: poster.class.name, post_id: poster.id}
      poster.reload
        # pry.binding
      end.to change(poster.reload, :child).by(1)
      
    end 

    it "should not create new comment" do
      
      post :create, comment: {name: 'New name', text: "New text",
                              commentable_id: poster.id, commentable_type: poster.class.name, post: poster}
      
      
      expected_json = {message: "Fucking error!"}.to_json
      expect(response.body).to eq expected_json
    end 
    

    it "should  create new comment for comment" do
      
      post :create, comment: {name: comment.name, text: comment.text, commentable_id: comment.id, commentable_type: comment.class.name, post_id: poster.id}
      
      
      expected_json = {message: "Your comment saved"}.to_json
      expect(response.body).to eq expected_json
    end

   
    it "should inc comment count by 1" do
      
      expect do 
          post :create, comment: {name: comment.name, text: comment.text, 
                             commentable_id: comment.id, commentable_type: comment.class.name, 
                             post_id: poster.id}
        
        comment.reload
        
        end.to change(Comment, :count).by(1)
      
      end
     
   


    
      

      
    it "should  inc child  by 1 for comments" do
      
       
      expect do 
      
      post :create, comment: {name: comment.name, text: comment.text, commentable_id: comment.id, commentable_type: comment.class.name, post_id: poster.id}
        
        comment.reload
        end.to change(comment.reload, :child).by(1)
        
      
      
     
    
      
    end
  
   describe "should inc shild and make correct path" do
      before do 
        @comment = FactoryGirl.create(:comment, post_id: poster.id, commentable: poster) 
        @arr = Array.new 
      end
      describe "post comment should have path eq '1'" do
        before do 
          3.times do 
            post :create, comment: {name: @comment.name,
                                    text: @comment.text,
                                    commentable_id: @comment.id,
                                    commentable_type: @comment.class.name,
                                    post_id: poster.id}
           @arr << Comment.last
          end
          @comment.reload
        end
        
        it "should have 3 child" do
          expect(@comment.child).to eq(3)
        end
        #parent comment path = "2"
        it "@comment path should eq 2" do
          
          expect(@comment.path).to eq("2")
        end

        (1..3).each do |n|
          #parent comment path = "2"
          it "child comment's path should eq 2.#{n} " do
            expect(@arr[n-1].path).to eq("2.#{n}")
          end
        end


      end
    end



  end
end
