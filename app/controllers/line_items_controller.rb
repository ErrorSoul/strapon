class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def create 
    @post = Post.find(params[:line_item][:post_id])
    @line_item = @cart.add_product(@post.id)
    if @line_item.save
      render json: {message: "OK"}
    else
      render json: {message: "Fucking Error"}
    end
  end


  def destroy
    
    line_item = @cart.line_items.find_by(post_id: params[:id])
    if line_item
      line_item.destroy
      render json: {message: "Line item deleted"}
    else
      render json: {message: "Something wrong"}
    end
  end


  private
    def line_item_params
      params.require(:line_item).permit(:post_id)
    end

end
