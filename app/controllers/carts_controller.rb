class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def show
    cart_id = session[:cart_id]
    cart = Cart.includes(:line_items => :post).find(cart_id)
    posts  = cart.line_items.map(&:post)
    render json: {posts: posts}
    
    
  end


  def destroy
    @cart.line_items.each(&:destroy)
    render json: {message: "Your cart has been cleaned"}
  end
end
