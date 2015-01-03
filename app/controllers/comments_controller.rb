class CommentsController < ApplicationController
  respond_to :json
  def create
     #ry.binding
    #@comment = commentable_type.constantize.find(commentable)
    if current_guess.nil?
      @comment = Comment.new(comment_params)
    else
      @comment = current_guess.comments.create(comment_params)
    end
    if @comment.save
      render json: {message: "Your comment saved", comment: @comment}, :include => :user 
    else
      render json: {message: "Fucking error!"}
    end
    
  end


  def show 
    
    @comments = Comment.where('post_id = ?', params[:id])
    render json: {comments: @comments},:include => { :user => { :only => [:name, :nickname, :image] } }
  end
  
  private

  def comment_params
      params.require(:comment).permit(:name, :text, :commentable_id, :commentable_type, :post_id)
  end
end
