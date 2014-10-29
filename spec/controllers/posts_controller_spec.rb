require 'spec_helper'
require 'pry'

describe PostsController do
  let!(:author) {FactoryGirl.create(:author_with_posts)}
  let! (:posts) {author.posts}
  let! (:post_id_1) { posts.first}
 
  before { sign_in author, no_capybara: true }
  after (:all) do
    Post.destroy_all
  end


  describe "index method" do
    it "should return posts" do
      #pry.binding
      get :index 
      expected_json = { posts: posts}.to_json
      expect(response.body).to eq expected_json
    end
  end

  
  describe "edit method" do
    it "should return post 1 " do
      get :edit, id: post_id_1.id
      expected_json = {post: post_id_1 }.to_json
      expect(response.body).to eq expected_json
    end
  end

  describe 'delete method' do
    it "should delete post" do 
      
      delete :destroy, id: post_id_1.id 

      expected_json = {message: "Your post deleted"}.to_json
      expect(response.body).to eq expected_json
      #pry.binding
      get :index
      new_posts = posts.dup
      new_posts.delete(post_id_1)
      expected_json ={posts: new_posts }.to_json
      expect(response.body).to eq expected_json
      
    end
  end

end
