class UserSessionsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  #require "pry"
  def create
    #pry.binding
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    #pry.binding
    user.add_cart(@cart)
    if user.save
      session[:user_id] = user.id
      session[:cart_id] = user.cart.id
      @user = user
   else
      @message = "Error"
    #render json: {user: @current_user}
    end
    
  end

  def destroy
    session[:user_id] = nil
    session[:cart_id] = nil
    render json: {message: "Exit"}
  end
end
