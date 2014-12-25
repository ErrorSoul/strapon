class CommentsController < ApplicationController
  respond_to :json
  def create
     #ry.binding
    #@comment = commentable_type.constantize.find(commentable)
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {message: "Your comment saved"}
    else
      render json: {message: "Fucking error!"}
    end
    
  end


  def show 
    
    @comments = Comment.where('post_id = ?', params[:id])
    render json: {comments: @comments}
  end
  
  private

  def comment_params
      params.require(:comment).permit(:name, :text, :commentable_id, :commentable_type, :post_id)
  end
end
