# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  post_id          :integer
#  path             :string(255)
#  child            :integer          default(0)
#  class_num        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#

require 'spec_helper'
require "pry"

describe Comment do
  before do 
    @user = FactoryGirl.create(:user)
    @comment = Comment.new(
                           text: "This is my first comment!",
                           user: @user,
                           post_id: 1,
                           path: "1.2",
                           class_num: 1,
                           commentable: nil,
                           child: nil )
  end
  after(:all) do
    Comment.destroy_all
  end

  subject{@comment}

  describe "comment model" do
    %i(user_id text post_id path class_num child commentable).each do |i|
      it {should respond_to(i)}
    end
    it {should be_valid}
  end


  describe "when attr not present" do 
    %i(text post_id ).each do |x|
    describe "#{x} is nil" do
        before {@comment.send("#{x}=", nil)}
        it { should be_invalid}
        
      end
    end
  end


  describe "path order" do
    let!(:post){FactoryGirl.create(:post)}
    let!(:comment_main){FactoryGirl.create(:comment, post: post, commentable: post)}
    let!(:comment_child_1){FactoryGirl.create(:comment, post: post, commentable: comment_main)}
    
    
    let!(:comment_child_2){FactoryGirl.create(:comment, post: post,commentable: comment_main)}
    
    it "should have the right comments in the right order" do
      #pry.binding
      expect(Comment.all).to eq [comment_main, comment_child_1, comment_child_2]
    end

    it "should post child eq to 2" do
      comment_main.reload
      expect(comment_main.child).to eq 2
    end
  end
end
