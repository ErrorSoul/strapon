class UserSessionsController < ApplicationController
  #require "pry"
  def create
    #pry.binding
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id 
    @user = user
    #render json: {user: @current_user}
    
  end

  def destroy
    session[:user_id] = nil
    render json: {message: "Exit"}
  end
end
