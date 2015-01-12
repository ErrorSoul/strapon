require 'spec_helper'

describe AuthorsController do
  let!(:author){FactoryGirl.create(:author)}
  let! (:file) {fixture_file_upload("dream.jpg", 'image/jpeg') }
  before do 
    sign_in author, no_capybara: true
  end
  
  describe "show method " do
    it "should return current_user" do
      get :show, id: 1
      expected_json = {author: author}.to_json
      expect(response.body).to eq expected_json
    end

  end

  describe "update method" do
    before do 
      @author = FactoryGirl.attributes_for(:author)
      
      
      #@author  = author
      #@author.name = "Van of None"
      #@author.password = 'foobarshina'
      #@author.password_confirmation = 'foobarshina'
      #@author.save
      #@author.reload
    end
    it "should update author"  do 
      
     
      patch :update, id: 1, author: @author
      author.reload
      expected_json = {message: "Your info updated", author: author}.to_json
      
      expect(response.body).to eq expected_json
    end


    it 'should update post with image' do
      author.asset = file
      author.save
      author.reload
      @author = FactoryGirl.attributes_for(:author)
      @author[:asset] = author.asset
      
      
     
      patch :update, id: 1,  author: @author
      author.reload
      expected_json = {message: "Your info updated", author: author}.to_json
      
      
      expect(response.body).to eq expected_json
    
    end
  end
  
    

end
