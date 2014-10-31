class PostsController < ApplicationController
  respond_to :json
  before_action :signed_in_user, only: [:create,:index]
  
  before_action :message_dict, only: [:update, :create ]
  before_action :signed_and_set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = current_user.posts.all
    render json: {posts: @posts}
  end

  def edit 
    render json: { post: @post }
  end

  

  def update
    if @post.update_attributes(post_params)
     check_asset
     render json: @message
    else
      render json: {errors: @post.errors.full_messages}
    end
  end

  def show
  end
  def new
  end

  def create 
  end
  
  def destroy
    @post.destroy
    render json: {message: "Your post deleted"}
  end
  private
  def signed_and_set_post
    signed_in_user
    set_post if current_user 
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

   def check_asset
      if @post.asset.filename
        @message[:url] = @post.asset.url
        
      end
   end
end
