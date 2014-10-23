require 'spec_helper'
require 'pry'



describe SessionsController do 
  let!(:author) { FactoryGirl.create(:author) }
  
  


  
  describe "POST create" do 
    
    context "with valid params" do
      it "an user is created and returned" do
        
        post :create, author: FactoryGirl.attributes_for(:author)
        #pry.binding
        author.reload
        expected_json = { author: author, authorized: 'true' }.to_json
        expect(response.body).to eq expected_json
      end
    end
    
    describe "with invalid params" do
      
      it "invalid password" do
        post :create, author: FactoryGirl.attributes_for(:invalid_author_password)
        expected_json = { authorized: "false" }.to_json
        expect(response.body).to eq expected_json
      end

      it "invalid login" do
        post :create, author: FactoryGirl.attributes_for(:invalid_author_login)
	
        expected_json = { authorized: "false" }.to_json
        expect(response.body).to eq expected_json
      end
    end
  end



  describe "DELETE destroy" do
    before (:each) do
      post :create, author: FactoryGirl.attributes_for(:author)
    end
      

    
    it "return false status of authorized" do 
      #pry.binding
      delete :destroy, id: 1 
      expected_json = { authorized: "false" }.to_json
            expect(response.body).to eq expected_json
    end
    
    it "destroys the sessions" do
      delete :destroy, id: 1
      expect(cookies[:remember_token]).to be_nil
    end
  end
end
