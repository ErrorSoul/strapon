require 'spec_helper'

describe User do
  before do 
    @user = User.new(name: "Fedor",
                     nickname: "@Emelya",
                     uid: "122",
                     provider: "twitter",
                     image: "http:/dfdfdf")
  end


  subject{ @user }

  describe "User model" do
    %i(name nickname uid provider image).each do |i|
      it {should respond_to(i)}
    end
    it {should be_valid}
  end
end
