require 'spec_helper'

describe Post do
  let(:author) { FactoryGirl.create(:author)}
  before { @post = author.posts.build(title: "My first post", 
                                     text: "Lorem ipsum",
                                     description: "Post about first post",
                                     keywords: "First, my, post"
                                      )}

  


  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:author_id) }
  it { should respond_to(:text)}
  it { should respond_to(:author) }
  it { should respond_to(:comments)}
  it {should respond_to(:description)}
  it {should respond_to(:keywords)}
  its(:author) { should eq author }

  it { should be_valid }
  describe "when author_id is not present" do
    before { @post.author_id = nil }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @post.title = " " }
    it { should_not be_valid }
  end

  describe "with blank text" do
    before { @post.text = " " }
    it { should_not be_valid }
  end
  
  describe "with blank description" do
    before { @post.description = " " }
    it { should_not be_valid }
  end

  describe "with blank keywords" do
    before { @post.keywords = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @post.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @post.description = "a" * 141 }
    it { should_not be_valid }
  end
  describe "with keywords that is too long" do
    before { @post.keywords = "a" * 141 }
    it { should_not be_valid }
  end
 
end
