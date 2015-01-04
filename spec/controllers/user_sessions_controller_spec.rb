require 'spec_helper'

describe UserSessionsController do

  

  describe "GET 'destroy'" do
    it "returns http success" do
      delete  :destroy
      expected_json = {message: "Exit"}.to_json
      expect(response.body).to eq expected_json
    end
  end

end
