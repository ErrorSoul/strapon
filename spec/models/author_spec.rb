require 'spec_helper'

describe Author do
  before do 
    @author = Author.new(name: "Arnold", login: "arni",
                         password: "foobar", password_confirmation: "foobar",
                         bio: "I'm superstar and you know it")
  end
  subject { @author }
  it { should respond_to(:name)}
  it { should respond_to(:login)}
  it { should respond_to(:bio)}
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  
  it { should be_valid }
  # name
  describe "when name is not present" do
    before { @author.name = " "}
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @author.name = "a" * 25 }
    it { should_not be_valid }
  end

  describe "when name is too short" do 
    before { @author.name = "a" * 3 }
    it { should_not be_valid }
  end
  
  #login
  describe "when login is not present" do
    before { @author.login = " "}
    it { should_not be_valid }
  end

  describe "when login is too long" do
    before { @author.login = "a" * 13 }
    it { should_not be_valid }
  end

  describe "when login is too short" do 
    before { @author.login = "a" * 3 }
    it { should_not be_valid }
  end


  describe "when login is already taken " do 
    before do
      user_with_same_email = @author.dup
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  #password
   describe "when password is not present" do
    before do
      @author = Author.new(name: "Example User", login: "user@example.com",
                         bio: "My bio is my bio",
                         password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @author.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end


  describe "authentication" do 
    let(:user) { Author.create(name: "Oleg", login: "oleg@mail.ru",
                               bio: "oleg's bio",
                             password: "hunter2", password_confirmation: "hunter2")}
    it "authenticates with correct password" do
      expect(user.authenticate("hunter2")).to be 
    end

    it "authenticates with incorrect password" do
      expect(user.authenticate("hunter1")).to_not be
    end
  end


  describe "return value of authenticate method" do
    before { @author.save }
    let(:found_user) { Author.find_by(login: @author.login) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@author.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    
  end
  
  describe "with a password that's too short" do
      before { @author.password = @author.password_confirmation = "a" * 1}
      
      it { should_not be_valid }
    end


  

  #bio 
  describe "when bio is not present" do
    before { @author.bio = " "}
    it { should_not be_valid }
  end

  describe "when bio is too long" do
    before { @author.bio = "a" * 141 }
    it { should_not be_valid }
  end
 
end
