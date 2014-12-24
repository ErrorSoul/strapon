class CommentsController < ApplicationController
  
  def create
    #pry.binding
    #@comment = commentable_type.constantize.find(commentable)
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {message: "Your comment saved"}
    else
      render json: {message: "Fucking error!"}
    end
    
  end

  private

  def comment_params
      params.require(:comment).permit(:name, :text, :commentable_id, :commentable_type, :post_id)
  end
end
