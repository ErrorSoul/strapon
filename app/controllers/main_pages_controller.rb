class MainPagesController < ApplicationController

  def intro
  end
  
  def index
  end
  def cart
  end

  def robots
  end

  def posts
    @posts = Post.all
    render json: {posts: @posts}
  end
end
