# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  nickname   :string(255)
#  image      :string(255)
#

require 'spec_helper'

describe User do
  let!(:user){FactoryGirl.create(:user)}
  let!(:author) {FactoryGirl.create(:author)}
  let!(:post1) {FactoryGirl.create(:post, author: author)}
  let!(:post2) {FactoryGirl.create(:post, author: author)}
  let!(:post3) {FactoryGirl.create(:post, author: author)}
  let!(:post4) {FactoryGirl.create(:post, author: author)}
  
  before do 
    
    @cart = Cart.create
    @user = User.new(name: "Fedor",
                     nickname: "@Emelya",
                     uid: "122",
                     provider: "twitter",
                     image: "http:/dfdfdf",
                     )
  end


  subject{ @user }

  describe "User model" do
    %i(name nickname uid provider image ).each do |i|
      it {should respond_to(i)}
    end
    it {should be_valid}
  end


  describe "add_cart" do 
    it "user without cart + empty cart = user with empty cart" do
      
      
      @cart_another = Cart.create
      @user.add_cart(@cart_another)
      @user.save
      expect(@user.cart.id).to eq @cart_another.id
    end
    

    it "user w cart + empty cart = user w cart" do
      @cart.add_product(post1.id)
      @cart.add_product(post2.id)
      @cart.save
      @user.add_cart(@cart)
      @user.save
      @another_cart = Cart.create
      @user.add_cart(@another_cart)
      @user.reload
      expect(@user.cart.id).to eq (@cart.id)
      expect(@user.cart.line_items.length).to eq 2

      
      
    end

    it "should user add " do
      @another_cart = Cart.create
      for c in [post1, post2] 
        @cart.add_product(c.id)
      end
      for c in [post3, post4]
        @another_cart.add_product(c.id)
      end
      for c in [@cart, @another_cart]
        c.save
        c.reload
      end
     
      @user.add_cart(@cart)
      @user.save
      @user.reload
      @user.add_cart(@another_cart)
      
      @user.reload
      posts_ids = [post1, post2, post3, post4].map(&:id)
      lines_ids = @user.cart.line_items.map(&:id)
      
      expect(@user.cart.line_items.length).to eq (4)
      expect(lines_ids).to eq posts_ids

    end

     it "should add only new line_items" do 
      @another_cart = Cart.create
      [@cart, @another_cart].each do |x|
        x.add_product(post1.id)
        x.add_product(post2.id)
        x.save
      end
      @user.add_cart(@cart)
      @user.save
      @user.reload
      @user.save
      @user.add_cart(@another_cart)
     
      @user.reload
      posts_ids = [post1, post2].map(&:id)
      lines_ids = @user.cart.line_items.map(&:post_id)
     
      expect(@user.cart.line_items.length).to eq 2
      expect(posts_ids).to eq lines_ids
      
      
    end

      

  end

    describe  "user w empty cart + non empty cart = user w non empty cart" do
      before do 
      @cart.add_product(post1.id)
      @cart.add_product(post2.id)
     
      
      if @cart.save
        @user.add_cart(@cart)
        if @user.save
          @user.reload
        end
      end
    end
    it "user cart id should eq @cart.id" do
          
      expect(@user.cart.id).to eq @cart.id
    end
    it "user cart line_items count eq " do
      expect(@user.cart.line_items.length).to eq 2
    end
    it "user cart line_items should eq adding posts" do
      posts_ids = [post1, post2].map(&:id)
      z = @user.cart.line_items.map(&:post_id)
      expect(z).to eq posts_ids
    end
  
  end

end
    



    

 
      
      

