require 'spec_helper'
require "pry"

describe "Authentication" do
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:author) { FactoryGirl.create(:author) }
      let(:my_post) { FactoryGirl.create(:post)}
      
      describe "submitting to the author  update action" do
        
          before { patch author_path(author) }
          specify { expect(response).to redirect_to(admin_path) }
        end


      describe "submitting to the post create action" do
        before { post posts_path(my_post) } 
        specify {expect(response).to redirect_to(admin_path)}
      end

       describe "submitting to the post update action" do
        before { patch post_path(my_post) } 
        specify {expect(response).to redirect_to(admin_path)}
      end

      describe "submitting to the post delete action" do
        before { delete post_path(my_post) } 
        specify {expect(response).to redirect_to(admin_path)}
      end
    end
  end
end
