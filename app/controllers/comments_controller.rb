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
      render json: {message: "Your comment saved", comment: @comment}, :include => [:user, :commentable => {:include => {:user => {:only => :name}}}]
    else
      render json: {message: @comment.errors}
    end
    
  end


  def show 
    
    @comments = Comment.includes(:user).where('post_id = ?', params[:id])
    
    render json:   {current_user: current_guess, comments: @comments.as_json(:include => [{:commentable => {:include => {:user => {:only => :name}}}}, :user]) } 
  end
  
  private

  def comment_params
      params.require(:comment).permit(:text, :commentable_id, :commentable_type, :post_id)
  end
end
