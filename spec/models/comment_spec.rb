require 'spec_helper'
require "pry"

describe Comment do
  before do 
    @comment = Comment.new(name: "Anonym",
                           text: "This is my first comment!",
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

  describe "clue model" do
    %i(name text post_id path class_num child commentable).each do |i|
      it {should respond_to(i)}
    end
    it {should be_valid}
  end


  describe "when attr not present" do 
    %i(name text post_id ).each do |x|
    describe "#{x} is nil" do
        before {@comment.send("#{x}=", nil)}
        it { should be_invalid}
        
      end
    end
  end


  describe "path order" do
    let!(:post){FactoryGirl.create(:post)}
    let!(:comment_child_1){FactoryGirl.create(:comment, post: post,path: "1.2")}
    let!(:comment_main){FactoryGirl.create(:comment, post: post, path: "1")}
    
    let!(:comment_child_2){FactoryGirl.create(:comment, post: post,path: "1.3")}
    
    it "should have the right comments in the right order" do
      expect(Comment.all).to eq [comment_main, comment_child_1, comment_child_2]
    end
  end
end
