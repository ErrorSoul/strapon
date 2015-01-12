#coding: utf-8
class AuthorsController < ApplicationController
before_action :signed_in_user


def show
  render json: {author: current_user}
end

def update
  if current_user.update_attributes(author_params)
     
     render json: {message: "Your info updated", author: current_user}
    else
      render json: {errors: current_user.errors.full_messages}
  end
  
end


private
def author_params
  params.require(:author).permit(:asset, :name, :login, :bio, :password, :password_confirmation)
end

end
