class PostsController < ApplicationController
  respond_to :json
  before_action :signed_in_user, only: [:create]

  before_action :signed_and_set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = current_user.posts.all
    render json: {posts: @posts}
  end

  def edit 
    render json: { post: @post }
  end

  

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
  private
  def signed_and_set_post
    signed_in_user
    set_post
  end

  def post_params
      params.require(:post).permit(:title, :text, :asset, :author_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def message_dict 
      @message = {message: "Your text saved"}
  end

  
end
