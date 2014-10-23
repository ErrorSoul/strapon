class PostsController < ApplicationController
  before_action :signed_in_user, only: [:update, :create, :destroy]
  def update
  end
  def show
  end
  def new
  end

  def create 
  end
  
  def destroy
  end
end
