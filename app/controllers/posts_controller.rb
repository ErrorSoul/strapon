class PostsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show]
  respond_to :json
  respond_to :html, only: [:show]
  before_action :signed_in_user, only: [:create,:index]
  
  before_action :message_dict, only: [:update, :create ]
  before_action :signed_and_set_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = current_user.posts.all
    respond_to do |format|
      format.html {redirect_to index_path}
      format.json  { render json: {posts: @posts} }
    end
    
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
    @post = Post.includes(:user).find(params[:id])
    post_ids = Post.pluck(:id)
    b = []
    while b.length < 3
      s  = post_ids.sample
      unless @post.id == s
        b << s
      end
    end
    @posts = Post.find(b)
    
  end
        
      
   
    
  
  def new
  end

  def create 
    @post = current_user.posts.build(post_params)
    if @post.save 
      check_asset
      @message[:post_id] = @post.id
      render json: @message
    else
      render json: {errors: @post.errors.full_messages }
    end
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
      params.require(:post).permit(:title, :text, :asset, :author_id, :description, :keywords)
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
